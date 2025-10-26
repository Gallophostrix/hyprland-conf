{pkgs, ...}: {
  home-manager.sharedModules = [
    (_: {
      home.packages = with pkgs; [
        hyprcursor
        bibata-cursors
      ];

      gtk.cursorTheme = {
        name = "Bibata-Modern-Classic";
        size = 26;
      };
    })
  ];
}
