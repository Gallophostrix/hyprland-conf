{pkgs, ...}: {
  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 26;
    hyprcursor.enable = true;
    gtk.enable = true;
  };
}
