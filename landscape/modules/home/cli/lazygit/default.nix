{
  lib,
  config,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli.lazygit;
in {
  options.${namespace}.cli.lazygit = {enable = mkEnableOption "lazygit";};
  config = mkIf cfg.enable {
    programs.lazygit = {
      enable = true;
      settings = {
        customCommands = [
          {
            # Push to specific repository
            # https://github.com/jesseduffield/lazygit/wiki/Custom-Commands-Compendium#pushing-to-a-specific-remote-repository
            key = "<c-P>";
            description = "Push to a specific remote repository";
            context = "global";
            loadingText = "Pushing ...";
            command = "git {{index .PromptResponses 1}} {{index .PromptResponses 0}}";
            prompts = [
              {
                type = "menuFromCommand";
                title = "Which remote repository to push to?";
                command = "bash -c \"git remote --verbose | grep '/.* (push)'\"";
                filter = "(?P<remote>.*)\\s+(?P<url>.*) \\(push\\)";
                valueFormat = "{{ .remote }}";
                labelFormat = "{{ .remote | bold | cyan }} {{ .url }}";
              }
              {
                type = "menu";
                title = "How to push?";
                options = [
                  {
                    value = "push";
                  }
                  {
                    value = "push --force-with-lease";
                  }
                  {
                    value = "push --force";
                  }
                ];
              }
            ];
          }
        ];
      };
    };
  };
}
