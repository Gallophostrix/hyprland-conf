{...}: {
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = false;
    enableFishIntegration = true;
    enableNushellIntegration = false;

    nix-direnv.enable = true;
  };
}
