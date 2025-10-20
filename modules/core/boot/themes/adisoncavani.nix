{pkgs}: let
  drv = pkgs.stdenvNoCC.mkDerivation {
    pname = "distro-grub-themes-nixos";
    version = "3.1";
    src = pkgs.fetchFromGitHub {
      owner = "AdisonCavani";
      repo = "distro-grub-themes";
      rev = "v3.2";
      hash = "sha256-U5QfwXn4WyCXvv6A/CYv9IkR/uDx4xfdSgbXDl5bp9M=";
    };
    installPhase = ''
      mkdir -p "$out"
      cp -r customize/nixos/* "$out"/
      test -f "$out/theme.txt" || { echo "theme.txt manquant dans customize/nixos"; exit 1; }
    '';
  };
in
  drv
