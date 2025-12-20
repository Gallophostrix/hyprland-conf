{pkgs, ...}: {
  programs = {
    zoxide.enable = true; # better cd
    bat.enable = true; # better cat
    fzf.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };

  home.packages = with pkgs; [
    eza # better ls
    fd # better find
    ripgrep # better grep

    jq # json formatting
    # ffmpeg # Terminal Video / Audio Editing
    tldr # better man
    unrar-wrapper # .rar handling
    unzip # .zip handling
    zip

    cmatrix # matrix effect
    figlet # ascii art
    lolcat # rainbow text
    microfetch # system info
  ];
}
