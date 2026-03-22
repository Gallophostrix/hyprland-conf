{hostVars, ...}: let
  inherit
    (hostVars)
    browser
    shell
    terminal
    tuiFileManager
    editor
    kbdLayout
    kbdVariant
    ;
in {
  wayland.windowManager.hyprland = {
    enable = true;
    systemd = {
      enable = true;
      variables = ["--all"];
    };
    settings = {
      "$mainMod" = "SUPER";
      "$shell" = shell;
      "$term" = terminal;
      "$editor" = editor;
      "$fileManager" = "${terminal} -e ${tuiFileManager}";
      "$browser" = browser;
      "$CONTROL" = "CTRL";
      "$kbdLayout" = kbdLayout;
      "$kbdVariant" = kbdVariant;
    };
    extraConfig = ''
      source = ~/.config/hypr/hyprland-noctalia.conf
    '';
  };
}
