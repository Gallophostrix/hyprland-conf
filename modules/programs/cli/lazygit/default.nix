# home/programs/dev/lazygit.nix
{pkgs, ...}: {
  home.shellAliases.lg = "lazygit";

  programs.lazygit = {
    enable = true;
    settings = {
      gui = {
        # To rework
        theme = {
          activeBorderColor = ["#89b4fa" "bold"];
          inactiveBorderColor = ["#45475a"];
          optionsTextColor = "#cdd6f4";
          selectedLineBgColor = "#313244";
          selectedRangeBgColor = "#313244";
          unstagedChangesColor = "#f38ba8";
        };
      };
      git.overrideGpg = true;
    };
  };
}
