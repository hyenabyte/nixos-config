{ pkgs
, lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.zed;

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
    ui_font_size = 14;
    buffer_font_size = 14;
    buffer_font_family = "Iosevka Comfy Wide";
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
            arguments = [ "--stdin-filepath" "{buffer_path}" ];
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
      HTML = {
        formatter = "prettier";
        format_on_save = "on";
      };
      CSS = {
        formatter = "prettier";
        format_on_save = "on";
      };
      Astro = {
        formatter = "prettier";
        code_actions_on_format = {
          "source.fixAll.eslint" = true;
        };
        format_on_save = "on";
      };
      Nix = {
        language_servers = [ "nixd" "!nil" ];
        formatter = "language_server";
        format_on_save = "on";
      };
      Gleam = {
        formatter = "language_server";
        format_on_save = "on";
      };
    };

    file_types = {
      "HTML" = [ "svg" ];
    };

    lsp.nixd.settings = {
      formatting.command = [ "nixpkgs-fmt" ];
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
    "gleam"
    "html"
    "nix"
    "sql"
    "toml"
    "unocss"
  ];
in
{
  options.${namespace}.apps.zed = { enable = mkEnableOption "Enable Zed"; };
  config = mkIf cfg.enable {
    programs.zed-editor = {
      enable = true;
      userSettings = settings;
      userKeymaps = keymap;
      extensions = extensions;
    };
  };
}
