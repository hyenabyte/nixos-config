{
  pkgs,
  lib,
  config,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.zed;

  jsonFormat = pkgs.formats.json {};

  settings = {
    show_inline_completions = false;
    assistant = {
        default_model = {
            provider = "zed.dev";
            model = "claude-3-5-sonnet-latest";
        };
        dock = "left";
        version = "2";
    };

    features = {
        inline_completion_provider = "supermaven";
    };

    telemetry = {
        metrics = false;
    };

    project_panel = {
        dock = "right";
    };

    theme = "Everforest Dark";
    ui_font_size = 16;
    buffer_font_size = 16;
    buffer_font_family = "Agave Nerd Font Mono";
    buffer_line_height = {
        custom = 2;
    };

    vim_mode = false;

    languages = {
        TypeScript = {
            formatter = "prettier";
            code_actions_on_format = {
                "source.fixAll.eslint" = true;
            };
            format_on_save = {
                external = {
                command = "prettier";
                arguments = ["--stdin-filepath" "{buffer_path}"];
                };
            };
        };
        TSX = {
            formatter = "prettier";
            code_actions_on_format = {
                "source.fixAll.eslint" = true;
            };
            format_on_save = "on";
        };
        JavaScript = {
            formatter = "prettier";
            code_actions_on_format = {
                "source.fixAll.eslint" = true;
            };
            format_on_save = "on";
        };
        Astro = {
            formatter = "prettier";
            code_actions_on_format = {
                "source.fixAll.eslint" = true;
            };
            format_on_save = "on";
        };
    };

    formatter = {
        code_actions = {
            "source.fixAll.eslint" = true;
        };
    };
  };

  keymap = [
    {
      context = "Editor";
      bindings = {
        "ctrl-'" = "editor::ToggleComments";
      };
    }
    {
        context = "Editor && !inline_completion";
        bindings = {
            "alt-<" = "editor::ShowInlineCompletion";
        };
    }
  ];

  extensions = [
    "astro"
    "everforest"
    "html"
    "nix"
    "unocss"
    "sql"
  ];
in {
  options.${namespace}.apps.zed = {enable = mkEnableOption "Enable Zed";};
  config = mkIf cfg.enable {
    programs.zed-editor = {
        enable = true;
        userSettings = settings;
        userKeymaps = keymap;
        extensions = extensions;
    };
  };
}
