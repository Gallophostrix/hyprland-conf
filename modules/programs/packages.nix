{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    bibata-cursors
    libnotify # For Notifications
  ];
}
