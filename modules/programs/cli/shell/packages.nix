{pkgs, ...}: {
  programs = {
    zoxide.enable = true; # better cd
    fzf.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };

  home.packages = with pkgs; [
    bat # better cat
    eza # better ls
    fd # better find
    ripgrep # better grep

    jq # json formatting
    # ffmpeg # Terminal Video / Audio Editing
    tldr # better man
    unrar # .rar handling
    unzip # .zip handling

    cmatrix # matrix effect
    figlet # ascii art
    lolcat # rainbow text
    microfetch # system info
  ];
}
