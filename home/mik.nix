{ config, pkgs, ... }:

{
  # User information
  home.username = "mik";
  home.homeDirectory = "/home/mik";

  # Configuration version
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  # Programs
  programs.git = {
    enable = true;
    userName = "Gallophostrix";
    userEmail = "gallophostrix@proton.me";
  };

  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = 0.9;
    };
  };

  programs.fish.enable = true;
  
  home.sessionVariables.SHELL = "${pkgs.fish}/bin/fish";

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.bat = {
    enable = true;
  };

  # Waybar config
  home.packages = with pkgs; [
    waybar
    pavucontrol
    nerd-fonts.jetbrains-mono
  ];

  home.file.".config/waybar/config".source = ./dotfiles/waybar/config;
  home.file.".config/waybar/style.css".source = ./dotfiles/waybar/style.css;

}
