{...}: {
  environment.variables."DIRENV_WARN_TIMEOUT" = "60s";
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = false;
    enableFishIntegration = true;
    enableNushellIntegration = false;
  };

  # home.sessionVariables = {
  #   # DIRENV_DIR = "/tmp/direnv";
  #   # DIRENV_CACHE = "/tmp/direnv-cache"; # Optional, for caching
  # };
}
