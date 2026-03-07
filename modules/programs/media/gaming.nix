{pkgs, ...}: {
  home.packages = with pkgs; [
    protontricks
  ];

  programs.mangohud = {
    enable = true;

    settings = {
      no_display = true;
      fps_limit = [60 0 240];
      fps_limit_method = "late";

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
