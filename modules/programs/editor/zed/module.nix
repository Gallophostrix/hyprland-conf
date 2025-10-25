{ config, lib, pkgs, ... }:
let
  cfg = config.programs.zed;
in
with lib; {
  options.programs.zed = {
    enable = mkEnableOption "Zed editor";

    package = mkOption {
      type = types.package;
      default = pkgs.zed-editor;
      description = "Zed package to install.";
    };

    settings = mkOption {
      type = types.attrs;
      default = { };
      example = { theme = "Catppuccin Mocha"; font_size = 15; telemetry = false; };
      description = "Contents of ~/.config/zed/settings.json";
    };

    extensions = mkOption {
      type = types.listOf types.str;
      default = [ ];
      example = [ "nix" "rust-analyzer" "python" ];
      description = "List written to ~/.config/zed/extensions.json";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    xdg.configFile."zed/settings.json".text =
      builtins.toJSON cfg.settings;

    xdg.configFile."zed/extensions.json" = mkIf (cfg.extensions != [ ]) {
      text = builtins.toJSON cfg.extensions;
    };
  };
}
