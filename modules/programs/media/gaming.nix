{pkgs, ...}: {
  home.packages = with pkgs; [
    steam-run
    gamescope
    proton-ge-bin
    wineWowPackages.staging
    protontricks
    protonup-qt
    vkbasalt
  ];

  programs.mangohud = {
    enable = true;
    enableSessionWide = true;

    settingsPerApplication = {
      mpv = {no_display = true;};
    };

    settings = {
      no_display = true;
      fps_limit = [60 0 144 165 240];
      fps_limit_method = "late";
      vsync = 2;
      gl_vsync = 1;

      toggle_hud = "Shift_R+F12";
      toggle_fps_limit = "Shift_R+F1";

      fps = true;
      show_fps_limit = true;
      frametime = true;
      frame_timing = true;
      present_mode = true;
      core_load = false;
      ram = true;

      cpu_stats = true;
      cpu_temp = true;
      cpu_power = true;
      cpu_text = "CPU";
      cpu_mhz = true;

      throttling_status = true;
      gpu_stats = true;
      gpu_temp = true;
      gpu_core_clock = true;
      gpu_mem_clock = true;
      gpu_power = true;
      gpu_text = "GPU";
      vram = true;
      # gpu_load_change
      # gpu_load_value=60,90
      # gpu_load_color=39F900,FDFD09,B22222
    };
  };
}
