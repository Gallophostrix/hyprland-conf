{ pkgs, ... }:
{
  home-manager.sharedModules = [
    (_: {
      programs.zathura = {
        enable = true;
        options = {
          # --- Zathura (document) ---
          recolor = true;
          recolor-keephue = true;
          recolor-lightcolor = "#1e1e2e"; # Mocha theme
          recolor-darkcolor = "#cdd6f4"; # Mocha theme
          window-title-basename = true;
          guioptions = "none";
          font = "JetBrainsMono Nerd Font 15";
          sandbox = "none";
          adjust-open = "width";
          zoom-center = true;
          scroll-page-aware = true;
          page-v-padding = 1;
          page-h-padding = 1;

          # Status bar (valeurs zathura)
          statusbar-h-padding = 8;
          statusbar-v-padding = 2;
          statusbar-basename = true;
          statusbar-home-tilde = true;
        };

        extraConfig = ''
          " ---------- Colors ----------
          set default-bg                "#1e1e2e"
          set default-fg                "#cdd6f4"
          set statusbar-bg              "#1e1e2e"
          set statusbar-fg              "#cdd6f4"
          set inputbar-bg               "#1e1e2e"
          set inputbar-fg               "#cdd6f4"
          set completion-bg             "#1e1e2e"
          set completion-fg             "#cdd6f4"
          set completion-group-bg       "#181825"
          set completion-group-fg       "#89b4fa"
          set completion-highlight-bg   "#89b4fa"
          set completion-highlight-fg   "#1e1e2e"
          set notification-bg           "#1e1e2e"
          set notification-fg           "#cdd6f4"
          set notification-warning-bg   "#fab387"
          set notification-warning-fg   "#1e1e2e"
          set notification-error-bg     "#f38ba8"
          set notification-error-fg     "#1e1e2e"

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
          map <Esc> nohl_search

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
          map g feedkeys :goto\

          " Open a file
          map o file_chooser
        '';
      };
    })
  ];
}
