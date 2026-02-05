{
  pkgs,
  lib,
  inputs,
  ...
}: {
  stylix = {
    enable = true;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 26;
    };

    targets = {
      grub.enable = false;
      fish.enable = false;

      chromium.enable = true;
    };
  };
}
