{pkgs, ...}: {
  programs.freetube = {
    enable = true;
    package = pkgs.freetube;
    settings = {
    };
  };
}
