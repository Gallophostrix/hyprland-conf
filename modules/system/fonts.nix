{pkgs, ...}: {
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      # Nerd Fonts
      maple-mono.NF
      pkgs.nerd-fonts.jetbrains-mono

      # Normal Fonts
      noto-fonts
      noto-fonts-color-emoji
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
    ];
    fontconfig = {
      enable = true;
      antialias = true;
      defaultFonts = {
        monospace = [
          "JetBrainsMono Nerd Font"
          "Maple Mono NF"
          "Noto Mono"
          "Noto Sans CJK JP"
          "DejaVu Sans Mono" # Default
        ];
        sansSerif = [
          "Noto Sans CJK JP"
          "Noto Sans"
          "DejaVu Sans" # Default
        ];
        serif = [
          "Noto Serif CJK JP"
          "Noto Serif"
          "DejaVu Serif" # Default
        ];
        emoji = ["Noto Color Emoji"];
      };
    };
  };
}
