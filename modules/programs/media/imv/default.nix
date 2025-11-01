{pkgs, ...}: {
  programs.imv = {
    enable = true;
    package = pkgs.imv;
    settings = {
      options = {
        overlay = true;
        overlay_position_bottom = true;
        overlay_font = "JetBrainsMono Nerd Font:12";
        overlay_text_color = "cdd6f4";
        overlay_background_color = "1e1e2e";
        overlay_background_alpha = "cc";
        overlay_text = "$imv_current_index/$imv_file_count — $(basename -- \"$imv_current_file\")  [$imv_scale%]";
        title_text = "$(basename -- \"$imv_current_file\")";
      };
    };
  };
}
