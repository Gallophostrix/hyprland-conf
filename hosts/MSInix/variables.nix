{
  # User Configuration
  username = "mik"; # Your username
  desktop = "hyprland";
  terminal = "alacritty";
  editor = "zeditor";
  browser = "brave";
  tuiFileManager = "yazi";
  sddmTheme = "pixel_sakura";
  defaultWallpaper = "kurzgesagt.webp"; # to change wallpaper: SUPER + SHIFT + W
  hyprlockWallpaper = "evening-sky.webp"; # See modules/interface/wallpapers for options
  shell = "fish";
  games = false; # Whether to enable the gaming module
  data = true; # Whether to import a data partition

  # Hardware Configuration
  videoDriver = "msi-setup"; # CRITICAL: Choose your GPU driver (nvidia, amdgpu, intel, or self-configured)
  hostname = "MSInix"; # Your system hostname

  # Localization
  clock24h = true; # 24H or 12H clock in waybar
  locale = "fr_FR.UTF-8"; # System locale
  timezone = "Europe/Paris"; # Your timezone
  kbdLayout = "fr"; # Keyboard layout
  kbdVariant = ""; # Keyboard variant (can be empty)
  consoleKeymap = "fr"; # TTY keymap
}
