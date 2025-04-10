{ lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.cli.yazi;
in
{
  options.${namespace}.cli.yazi = with types; {
    enable = mkEnableOption "Yazi";
  };

  config = mkIf cfg.enable {
    programs.yazi = {
      enable = true;

      settings = {
        keymap = {
          manager = {
            prepend_keymap = [

              {
                on = "<C-g>";
                run = ''
                  shell --block 'lazygit'
                '';
              }
            ];
          };
        };
      };
    };
  };
}
