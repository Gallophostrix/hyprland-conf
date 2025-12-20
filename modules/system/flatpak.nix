{inputs, ...}: {
  imports = [inputs.nix-flatpak.nixosModules.nix-flatpak];

  services = {
    flatpak = {
      enable = true;

      # List the Flatpak applications you want to install
      # Use the official Flatpak application ID (e.g., from flathub.org)
      # Examples:
      packages = [
        "com.github.tchx84.Flatseal" # Manage flatpak permissions - should always have this
        "io.github.flattool.Warehouse" # Manage flatpaks, clean data, remove flatpaks and deps
        #"it.mijorus.gearlever"           # Manage and support AppImages
        #"io.github.dvlv.boxbuddyrs"      #  Manage distroboxes
        #"de.schmidhuberj.tubefeeder"     # watch YT videos

        # Add other Flatpak IDs here, e.g., "org.mozilla.firefox"

        # Note : Collabora is installed manually for now
      ];

      # Optional: Automatically update Flatpaks when you run nixos-rebuild switch
      update.onActivation = true;
    };
  };

  systemd.services.flatpak-managed-install = {
    wants = ["network-online.target"];
    after = ["network-online.target"];
  };
}
