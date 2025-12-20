{
  pkgs,
  hostVars,
  ...
}: let
  username = hostVars.username;
  shellName = hostVars.shell;
  shellPkg =
    if shellName == "fish"
    then pkgs.fish
    else pkgs.bashInteractive;
in {
  users.mutableUsers = true;
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "input"
      "networkmanager"
      "video"
      "audio"
      "docker"
      "libvirtd"
      "kvm"
      "disk"
      "adbusers"
      "lp"
      "scanner"
      "vboxusers"
    ];
    shell = shellPkg;
    ignoreShellProgramCheck = true;
  };
  programs.dconf.enable = true;

  nix.settings.trusted-users = ["root" username];
}
