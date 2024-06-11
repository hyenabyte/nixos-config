{pkgs, ...}: {
  imports = [
    ./astro
    ./better-comments
    ./catppuccin
    ./color-highlight
    ./everforest
    ./file-icons
    ./gleam
    ./gruvbox-material
    ./helix-keymap
    ./icons-carbon
    ./markdown
    ./nix-lang
    ./prettier
    ./prisma
    ./project-manager
    ./rust
    ./trailing-spaces
  ];

  modules = {
    astro.enable = true;
    better-comments.enable = true;
    catppuccin.enable = true;
    color-highlight.enable = true;
    # everforest.enable = true;
    file-icons.enable = true;
    gleam.enable = true;
    # gruvbox-material.enable = true;
    helix-keymap.enable = true;
    icons-carbon.enable = true;
    markdown.enable = true;
    nix-lang.enable = true;
    prettier.enable = true;
    prisma.enable = true;
    project-manager.enable = true;
    rust.enable = true;
    trailing-spaces.enable = true;
  };

  programs.vscode = {
    mutableExtensionsDir = true;
    extensions = with pkgs.vscode-marketplace; [
      # Typescript
      # antfu.vite
      dbaeumer.vscode-eslint
      # denoland.vscode-deno

      # Styling
      # antfu.unocss
      # bradlc.vscode-tailwindcss

      # Testing
      # orta.vscode-jest

      # Emails
      # attilabuti.vscode-mjml

      # Code style
      stylelint.vscode-stylelint
      editorconfig.editorconfig

      # XML
      dotjoshjohnson.xml

      # TOML
      tamasfe.even-better-toml

      # JSON
      sissel.json-script-tag

      # Git
      # donjayamanne.githistory
      eamodio.gitlens

      # Dotenv
      mikestead.dotenv

      # Eta
      # shadowtime2000.eta-vscode

      # Caddyfile
      zamerick.vscode-caddyfile-syntax

      # Debug
      firefox-devtools.vscode-firefox-debug

      # Makefile
      # ms-vscode.makefile-tools

      # Github
      # github.codespaces
      # github.vscode-github-actions

      # Docker
      # ms-azuretools.vscode-docker

      # Remotes
      ms-vscode-remote.remote-containers
      ms-vscode-remote.remote-ssh

      # Quality of life extensions
      christian-kohler.path-intellisense
      formulahendry.auto-close-tag
      formulahendry.auto-rename-tag
      meganrogge.template-string-converter
      vincaslt.highlight-matching-tag
      usernamehw.errorlens

      # Hotkeys / Interactions
      # vscodevim.vim

      # Visual customization
      # jdinhlife.gruvbox
      # monokai.theme-monokai-pro-vscode
      # pedrotpo.theme-darktooth-material
      # poorchop.theme-darktooth
    ];
  };
}
