{
  pkgs,
  lib,
  ...
}: let
  thunarPlugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
    thunar-media-tags-plugin
  ];
in {
  # Core file manager + plugins
  home.packages = with pkgs;
    [
      xfce.thunar
    ]
    ++ thunarPlugins
    ++ [
      # Archive GUI + backends
      file-roller # or xarchiver / engrampa

      # Optional but very useful for Thunar
      gvfs # trash, smb://, mtp, etc.
    ];

  # Thumbnails in Thunar (covers, photos, etc.)
  # services.tumbler.enable = true;

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
