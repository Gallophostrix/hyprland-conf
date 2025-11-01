{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.gpuOffload;

  mkOffloadWrapper = name:
    pkgs.writeShellScriptBin "${name}-nvidia" ''
      exec nvidia-offload ${lib.escapeShellArg name} "$@"
    '';

  mkVaapiWrapper = name:
    pkgs.writeShellScriptBin "${name}-nvidia" ''
      export LIBVA_DRIVER_NAME=nvidia
      exec nvidia-offload ${lib.escapeShellArg name} "$@"
    '';

  toDesktopKey = n: "${n}-nvidia";

  # set of wrappers for normal apps
  normalApps = builtins.filter (n: !(builtins.elem n cfg.vaapiApps)) cfg.apps;

  wrappers =
    (map mkOffloadWrapper normalApps)
    ++ (map mkVaapiWrapper cfg.vaapiApps);

  desktopEntries = lib.listToAttrs (map
    (n: {
      name = toDesktopKey n;
      value = {
        name = "${lib.toUpper (lib.substring 0 1 n)}${lib.substring 1 (lib.stringLength n - 1) n} (NVIDIA)";
        exec = "${toDesktopKey n} %U";
        terminal = false;
        categories = ["Utility"];
        comment = "Launch ${n} on the dGPU via PRIME Offload";
        icon = n;
      };
    })
    cfg.apps);

  nvo = pkgs.writeShellScriptBin "nvo" ''
    # usage: nvo <cmd> [args...]
    exec nvidia-offload "$@"
  '';
in {
  options.gpuOffload = {
    apps = lib.mkOption {
      type = with lib.types; listOf str;
      default = [];
      example = ["steam" "blender" "mpv"];
      description = "Programs to launch on the dGPU via PRIME Offload";
    };
    vaapiApps = lib.mkOption {
      type = with lib.types; listOf str;
      default = [];
      example = ["mpv"];
      description = " Programs using VA-API NVIDIA (LIBVA_DRIVER_NAME=nvidia).";
    };
    addAliasNvo = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Add an alias 'nvo' for offloading any command from the terminal.";
    };
  };

  config = {
    home.packages =
      (
        if cfg.addAliasNvo
        then [nvo]
        else []
      )
      ++ wrappers;

    xdg.desktopEntries = desktopEntries;
  };
}
