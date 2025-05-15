{ pkgs
, lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.tailscale;
in
{
  # Credit to jakehamilton on this one
  # https://github.com/jakehamilton/config/blob/main/modules/nixos/services/tailscale/default.nix

  options.${namespace}.services.tailscale = with types; {
    enable = mkEnableOption "Enable Tailscale";
    autoconnect = {
      enable = mkBoolOpt false "Whether or not to enable automatic connection to Tailscale";
      key = mkOpt str "" "The authentication key to use";
    };
    acceptRoutes = mkBoolOpt true "Accept routes";
    useRoutingFeatures = mkOpt str "client" "client | server | both | none";
    isExitNode = mkBoolOpt false "Advertise self as exit node";
    allowLanAccess = mkBoolOpt false "Allow LAN Access";
    subnetRouter = {
      enable = mkBoolOpt false "Act as subnet router";
      advertiseRoutes = mkOpt (listOf str) [ ] "The routes for the subnet router to advertise";
    };
  };

  config =
    let
      exitNodeFlag = if cfg.isExitNode then [ "--advertise-exit-node" ] else [ ];
      acceptRoutesFlag = if cfg.acceptRoutes then [ "--accept-routes" ] else [ ];
      lanAccessFlag = if cfg.allowLanAccess then [ "--exit-node-allow-lan-access" ] else [ ];
      advertiseRoutes = strings.concatStringsSep "," cfg.subnetRouter.advertiseRoutes;
      subnetRoutes = if cfg.subnetRouter.enable then [ "--advertise-routes=${advertiseRoutes}" ] else [ ];

      extraFlags = [ ]
        ++ exitNodeFlag
        ++ acceptRoutesFlag
        ++ lanAccessFlag
        ++ subnetRoutes;
    in
    mkIf cfg.enable {
      assertions = [
        {
          assertion = cfg.autoconnect.enable -> cfg.autoconnect.key != "";
          message = "${namespace}.services.tailscale.autoconnect.key must be set";
        }
      ];

      environment.systemPackages = [ pkgs.tailscale ];
      services.tailscale = {
        enable = true;
        useRoutingFeatures = cfg.useRoutingFeatures;

        extraSetFlags = [
        ] ++ extraFlags;
      };

      networking = {
        firewall = {
          trustedInterfaces = [ config.services.tailscale.interfaceName ];
          allowedUDPPorts = [ config.services.tailscale.port ];

          # Strict reverse path filtering breaks Tailscale exit node use and some subnet routing setups.
          checkReversePath = "loose";
        };

        networkmanager.unmanaged = [ "tailscale0" ];
      };

      systemd.services.tailscale-autoconnect = mkIf cfg.autoconnect.enable {
        description = "Automatic connection to Tailscale";

        # Make sure tailscale is running before trying to connect to tailscale
        after = [ "network-pre.target" "tailscale.service" ];
        wants = [ "network-pre.target" "tailscale.service" ];
        wantedBy = [ "multi-user.target" ];

        # Set this service as a oneshot job
        serviceConfig.Type = "oneshot";

        # Have the job run this shell script
        script = with pkgs; ''
          # Wait for tailscaled to settle
          sleep 2

          # Check if we are already authenticated to tailscale
          status="$(${tailscale}/bin/tailscale status -json | ${jq}/bin/jq -r .BackendState)"
          if [ $status = "Running" ]; then # if so, then do nothing
            exit 0
          fi

          # Otherwise authenticate with tailscale
          ${tailscale}/bin/tailscale up -authkey "${cfg.autoconnect.key}"
        '';
      };
    };
}
