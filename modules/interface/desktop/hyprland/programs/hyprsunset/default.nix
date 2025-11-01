{ ... }:
{
  home-manager.sharedModules = [
    (_: {
      services.hyprsunset = {
        enable = true;
        settings = {
          profile = [
            {
              time = "6:00";
              identity = true;
            }

            {
              time = "22:00";
              temperature = 3500;
              gamma = 0.8;
            }
          ];
        };
      };
    })
  ];
}
