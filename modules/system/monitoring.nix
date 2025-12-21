{...}: {
  services = {
    power-profiles-daemon = {
      enable = true;
    };
    # tuned = {
    #   enable = true;
    # };
  };
}
