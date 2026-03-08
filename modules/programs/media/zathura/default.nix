{pkgs, ...}: {
  programs.zathura = {
    enable = true;
    options = {
      recolor = true;
      recolor-keephue = true;
      window-title-basename = true;
      guioptions = "none";
      font = "JetBrainsMono Nerd Font 15";
      adjust-open = "width";
      zoom-center = true;
      scroll-page-aware = true;
      page-v-padding = 1;
      page-h-padding = 1;

      statusbar-h-padding = 8;
      statusbar-v-padding = 2;
      statusbar-basename = true;
      statusbar-home-tilde = true;
    };

    extraConfig = ''
      " ---------- Colors ----------
      include noctaliarc

      " ---------- Keybinds ----------
      " Movements (Vim)
      map j scroll down
      map k scroll up
      map h scroll left
      map l scroll right

      " Zoom
      map + zoom in
      map - zoom out

      " Page navigation
      map <C-j> navigate next
      map <C-k> navigate previous

      " Recolor
      map i recolor

      " Quit
      map q quit

      " Search
      map s feedkeys /
      map n search forward
      map N search backward
      map <Esc> nohlsearch

      " Pages-per-row toggle → `p`
      map p toggle_page_mode

      " Fullscreen
      map f toggle_fullscreen

      " Index
      map t toggle_index

      " Rotation
      map r rotate rotate-cw
      map R rotate rotate-ccw

      " Window size
      map a adjust_window best-fit
      map w adjust_window width

      " Reload
      map <C-r> reload

      " UI switch
      map S toggle_statusbar
      map : focus_inputbar

      " Go to
      map g feedkeys ":goto "

      " Open a file
      map o file_chooser
    '';
  };
  home.packages = with pkgs; [
    pdfarranger
  ];
}
