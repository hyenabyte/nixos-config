{ pkgs
, lib
, config
, namespace
, inputs
, ...
}:
with lib;
with lib.${namespace}; let
  inherit (inputs.nix-minecraft.lib) collectFilesAt;
  cfg = config.${namespace}.services.minecraft;
in
{
  options.${namespace}.services.minecraft = with types; {
    enable = mkEnableOption "minecraft";
  };
  config = mkIf cfg.enable {

    services.minecraft-servers = {
      enable = true;
      eula = true;
      openFirewall = true;

      servers.raspberry-flavor =
        let
          modpack = pkgs.fetchPackwizModpack {
            url = "https://asphodel.cc/packwiz/Ports/Curse/Raspberry-Server/pack.toml";
            packHash = "sha256-EPeGrQUMtOfD9DT9vRX+fhqNqvcqd1ktjE/A6J+bB60=";
          };
        in
        {
          enable = true;

          autoStart = true;
          package = pkgs."${namespace}".forgeServers.forge-1_19_2;
          jvmOpts = "-Xmx4G -Xms2G";

          serverProperties = {
            server-port = 25567;
            difficulty = 1;
            gamemode = 0;
            max-players = 10;
            motd = "NixOS Minecraft server!";
            white-list = true;
            # enable-rcon = true;
            # "rcon.password" = "hunter2";
          };
          whitelist = {
            hyenabyte = "0d262564-0dc0-411a-a12d-86990cd05e07";
          };

          symlinks = {
            mods = "${modpack}/mods";
            # mods = collectFilesAt modpack "mods" // {
            # "mods/fabric-api" = pkgs.fetchurl {
            #   pname = "fabric-api";
            #   version = "0.77.0+1.19.2";
            #   url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/6g95K303/${pname}-${version}.jar";
            #   hash = "";
            # };
            # };
          };
          files = collectFilesAt modpack "config" // { };
        };
    };
  };
}
