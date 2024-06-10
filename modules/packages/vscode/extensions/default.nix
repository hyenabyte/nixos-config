{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./astro
    ./better-comments
    ./color-highlight
    # ./everforest
    ./gleam
    # ./gruvbox-material
    ./markdown
    ./nix-lang
    ./prettier
    ./prisma
    ./project-manager
    ./rust
    # ./sql-tools
    ./trailing-spaces
  ];

  astro.enable = true;
  better-comments.enable = true;
  color-highlight.enable = true;
  #! Not found in nixpkgs
  # everforest.enable = true;
  gleam.enable = true;
  #! Not found in nixpkgs
  # gruvbox-material.enable = true;
  markdown.enable = true;
  nix-lang.enable = true;
  prettier.enable = true;
  prisma.enable = true;
  project-manager.enable = true;
  rust.enable = true;
  #! Not found in nixpkgs
  # sql-tools.enable = true;
  trailing-spaces.enable = true;

  programs.vscode.extensions = with pkgs.vscode-extensions; [
    # Typescript
    #! Not found in nixpkgs
    # antfu.vite
    dbaeumer.vscode-eslint
    denoland.vscode-deno

    # Styling
    #! Not found in nixpkgs
    # antfu.unocss
    bradlc.vscode-tailwindcss

    # Testing
    #! Not found in nixpkgs
    # orta.vscode-jest

    # Emails
    #! Not found in nixpkgs
    # attilabuti.vscode-mjml

    # Code style
    stylelint.vscode-stylelint
    editorconfig.editorconfig

    # XML
    dotjoshjohnson.xml

    # TOML
    tamasfe.even-better-toml

    # JSON
    #! Not found in nixpkgs
    # sissel.json-script-tag

    # Git
    donjayamanne.githistory
    eamodio.gitlens

    # Dotenv
    mikestead.dotenv

    # Eta
    #! Not found in nixpkgs
    # shadowtime2000.eta-vscode

    # Caddyfile
    #! Not found in nixpkgs
    # zamerick.vscode-caddyfile-syntax

    # Debug
    firefox-devtools.vscode-firefox-debug

    # Makefile
    ms-vscode.makefile-tools

    # Github
    github.codespaces
    github.vscode-github-actions

    # Docker
    ms-azuretools.vscode-docker

    # Remotes
    ms-vscode-remote.remote-containers
    ms-vscode-remote.remote-ssh
    #! Not found in nixpkgs
    # ms-vscode-remote.remote-ssh-edit
    #! Not found in nixpkgs
    # ms-vscode.remote-explorer

    # Quality of life extensions
    #! Not found in nixpkgs
    # chouzz.vscode-better-align
    christian-kohler.path-intellisense
    formulahendry.auto-close-tag
    formulahendry.auto-rename-tag
    #! Not found in nixpkgs
    # meganrogge.template-string-converter
    vincaslt.highlight-matching-tag
    usernamehw.errorlens

    # Hotkeys / Interactions
    #! Not found in nixpkgs
    # silverquark.dancehelix
    vscodevim.vim

    # Visual customization
    antfu.icons-carbon
    catppuccin.catppuccin-vsc
    emmanuelbeziat.vscode-great-icons
    file-icons.file-icons
    jdinhlife.gruvbox
    #! Not found in nixpkgs
    # monokai.theme-monokai-pro-vscode
    #! Not found in nixpkgs
    # pedrotpo.theme-darktooth-material
    #! Not found in nixpkgs
    # poorchop.theme-darktooth
  ];
}
