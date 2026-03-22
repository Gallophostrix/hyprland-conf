{...}: {
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    systemd.enable = true;
    installBatSyntax = true;
    settings = {
      font-feature = ["calt" "liga" "ss01" "ss02" "ss19" "ss20"];

      window-decoration = false; # Hyprland tiling
      window-padding-x = 10;
      window-padding-y = 10;
      window-padding-balance = true;

      scrollback-limit = 10000;

      clipboard-read = "allow";
      clipboard-write = "allow";
      copy-on-select = false;

      shell-integration-features = "cursor,sudo,title,ssh-env";

      cursor-style = "block";
      cursor-style-blink = false;

      config-file = "~/.config/ghostty/themes/noctalia";
    };
  };
}
