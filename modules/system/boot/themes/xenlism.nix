{pkgs}: let
  drv = pkgs.stdenvNoCC.mkDerivation {
    pname = "xenlism-grub-4k-nixos";
    version = "main";
    src = pkgs.fetchFromGitHub {
      owner = "xenlism";
      repo = "grub-themes";
      rev = "main";
      hash = "sha256-ProTKsFocIxWAFbYgQ46A+GVZ7mUHXxZrvdiPJqZJ6I=";
    };
    installPhase = ''
      mkdir -p "$out"
      cp -r xenlism-grub-4k-nixos/Xenlism-Nixos/* "$out"/
      test -f "$out/theme.txt" || { echo "theme.txt manquant dans xenlism-grub-4k-nixos/Xenlism-Nixos"; exit 1; }
    '';
  };
in
  drv
