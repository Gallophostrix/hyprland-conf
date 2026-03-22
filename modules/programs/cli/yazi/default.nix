{...}: {
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      mgr = {
        sort_by = "natural";
        sort_dir_first = true;
        linemode = "size";
        show_hidden = true;
        show_symlink = true;
        ratio = [
          # or 0 3 4
          1
          3
          4
        ];
      };
      opener = {
        pdf = [
          {
            run = "zathura %s";
            block = true;
          }
        ];
        picture = [
          {
            run = "imv %d1";
            block = true;
          }
        ];
        video = [
          {
            run = "mpv --loop %s";
            block = true;
          }
        ];
        editor = [
          {
            run = "$EDITOR %s";
            block = true;
          }
        ];
        nano = [
          {
            run = "nano %s";
            block = true;
          }
        ];
        office = [
          {
            run = "com.collabora.Office %s";
            block = true;
          }
        ];
      };
      open.prepend_rules = [
        # --- PDF ---
        {
          mime = "application/pdf";
          use = "pdf";
        }

        # --- Images ---
        {
          mime = "image/*";
          use = "picture";
        }

        # --- Vidéo ---
        {
          mime = "video/*";
          use = "video";
        }

        # --- Texte ---
        {
          mime = "text/*";
          use = ["editor" "nano"];
        }

        # --- Office ---
        {
          name = "*.docx";
          use = "office";
        }
        {
          name = "*.doc";
          use = "office";
        }
        {
          name = "*.xlsx";
          use = "office";
        }
        {
          name = "*.xls";
          use = "office";
        }
      ];
    };
    keymap = {
      mgr.prepend_keymap = [
        {
          on = ["<S-e>"];
          run = "open --interactive";
        }
        {
          on = ["d"];
          run = "remove --force";
        }
      ];
    };
  };
}
