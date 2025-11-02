# Check
{
  pkgs,
  lib,
  ...
}: {
  # Install Thunar and its plugins at user level
  home.packages = with pkgs; [
    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.thunar-volman
    xfce.thunar-media-tags-plugin

    # Archive backends and GUI
    file-roller # or xarchiver / engrampa
    p7zip
    zip
  ];

  # Optionnel : associer file-roller aux archives (MIME)
  xdg.mimeApps.enable = true;
  xdg.mimeApps.defaultApplications = {
    "application/zip" = ["org.gnome.FileRoller.desktop"];
    "application/x-7z-compressed" = ["org.gnome.FileRoller.desktop"];
    "application/x-tar" = ["org.gnome.FileRoller.desktop"];
    "application/x-bzip2" = ["org.gnome.FileRoller.desktop"];
    "application/x-xz" = ["org.gnome.FileRoller.desktop"];
  };
}
