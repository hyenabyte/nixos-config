{ pkgs
, lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.system.xdg.mimeapps;
in
{
  options.${namespace}.system.xdg.mimeapps = { enable = mkEnableOption "xdg-mimeapps"; };
  config = mkIf cfg.enable {
    xdg.mime = {
      enable = true;
      addedAssociations = {
        # "application/pdf" = [
        #   "okularApplication_pdf.desktop"
        # ];
      };
      defaultApplications =
        let
          imageViewer = "org.gnome.Loupe.desktop";
          webBrowser = "userapp-Zen-L19102.desktop";
        in
        {
          # Images
          "image/gif" = "${imageViewer}";
          "image/jpeg" = "${imageViewer}";
          "image/png" = "${imageViewer}";
          "image/webp" = "${imageViewer}";
          "image/svg" = "org.inkscape.Inkscape.desktop";


        };
    };
  };
}
