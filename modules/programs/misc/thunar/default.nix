{pkgs, ...}: let
  thunarPlugins = with pkgs; [
    thunar-archive-plugin
    thunar-volman
    thunar-media-tags-plugin
  ];
in {
  home.packages = with pkgs;
    [
      thunar
    ]
    ++ thunarPlugins
    ++ [
      file-roller
    ];

  xdg.mimeApps.enable = true;
  xdg.mimeApps.defaultApplications = {
    "application/zip" = ["org.gnome.FileRoller.desktop"];
    "application/x-7z-compressed" = ["org.gnome.FileRoller.desktop"];
    "application/x-tar" = ["org.gnome.FileRoller.desktop"];
    "application/x-bzip2" = ["org.gnome.FileRoller.desktop"];
    "application/x-xz" = ["org.gnome.FileRoller.desktop"];
  };
}
