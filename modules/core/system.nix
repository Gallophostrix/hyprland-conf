{
  self,
  inputs,
  host,
  pkgs,
  overlays,
  ...
}:
let
  inherit (import ../../hosts/${host}/variables.nix)
    consoleKeymap
    kbdLayout
    kbdVariant
    locale
    timezone
    ;
in
{
  imports = [ inputs.nix-index-database.nixosModules.nix-index ];
  programs = {
    nix-index-database.comma.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
  services.xserver = {
    enable = true;
    exportConfiguration = true; # Make sure /etc/X11/xkb is populated so localectl works correctly
    xkb = {
      layout = "${kbdLayout}";
      variant = "${kbdVariant}";
    };
  };
  nix = {
    # Nix Package Manager Settings
    settings = {
      download-buffer-size = 200000000;
      auto-optimise-store = true; # May make rebuilds longer but less size
      substituters = [
        "https://cache.nixos.org/"
        "https://nix-community.cachix.org/"
        "https://chaotic-nyx.cachix.org/"
        "https://cachix.cachix.org"
        "https://nix-gaming.cachix.org/"
        "https://hyprland.cachix.org"
        # "https://nixpkgs-wayland.cachix.org"
        # "https://devenv.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
        "cachix.cachix.org-1:eWNHQldwUO7G2VkjpnjDbWwy4KQ/HNxht7H4SSoMckM="
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        # "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
        # "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      ];
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      use-xdg-base-directories = false;
      warn-dirty = false;
      keep-outputs = true;
      keep-derivations = true;
    };
    optimise.automatic = true;
    package = pkgs.nixVersions.latest;
  };
  time.timeZone = "${timezone}";
  i18n.defaultLocale = "${locale}";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "${locale}";
    LC_IDENTIFICATION = "${locale}";
    LC_MEASUREMENT = "${locale}";
    LC_MONETARY = "${locale}";
    LC_NAME = "${locale}";
    LC_NUMERIC = "${locale}";
    LC_PAPER = "${locale}";
    LC_TELEPHONE = "${locale}";
    LC_TIME = "${locale}";
  };
  environment.variables = {
    templates = "${self}/dev-shells";
    NIXOS_OZONE_WL = "1";

    # These are the defaults, and xdg.enable does set them, but due to load
    # order, they're not set before environment.variables are set, which could
    # cause race conditions.
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_BIN_HOME = "$HOME/.local/bin";
  };

  console.keyMap = "${consoleKeymap}";
  nixpkgs = {
    overlays = builtins.attrValues overlays;
    config = {
      allowUnfree = true;
      # allowUnfreePredicate = _: true;
    };
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"
}
