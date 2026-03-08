{...}: {
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    settings = {
      mgr = {
        sort_by = "natural";
        sort_dir_first = true;
        linemode = "size"; # or size, permissions, owner, mtime
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
            run = "zathura \"$@\"";
            block = true;
            for = "unix";
          }
        ];
        picture = [
          {
            run = "sh -lc 'cd \"$(dirname \"$0\")\" && exec imv .'";
            block = true;
            for = "unix";
          }
        ];
        video = [
          {
            run = "sh -lc 'cd \"$(dirname \"$0\")\" && exec mpv --loop .'";
            block = true;
            for = "unix";
          }
        ];
        editor = [
          {
            run = "$EDITOR \"$0\"";
            block = true;
            for = "unix";
          }
        ];
        nano = [
          {
            run = "nano \"$0\"";
            block = true;
            for = "unix";
          }
        ];
        office = [
          {
            run = "com.collabora.Office \"$0\"";
            block = true;
            for = "unix";
          }
        ];
      };
      open.prepend_rules = [
        # --- PDF ---
        {
          mime = "application/pdf";
          use = "pdf";
        }
        {
          name = "*.pdf";
          use = "pdf";
        }

        # --- Images ---
        {
          mime = "image/*";
          use = "picture";
        }
        {
          name = "*.png";
          use = "picture";
        }
        {
          name = "*.jpg";
          use = "picture";
        }
        {
          name = "*.jpeg";
          use = "picture";
        }
        {
          name = "*.gif";
          use = "picture";
        }
        {
          name = "*.webp";
          use = "picture";
        }

        # --- Vidéo ---
        {
          mime = "video/*";
          use = "video";
        }
        {
          name = "*.mp4";
          use = "video";
        }
        {
          name = "*.webm";
          use = "video";
        }

        # --- Texte ---
        {
          mime = "text/*";
          use = ["editor" "nano"];
        }
        {
          name = "*.txt";
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
      keymap = {
        mgr.prepend_keymap = [
          {
            on = ["e"];
            run = "open";
          }
          {
            on = ["<S-e>"];
            run = "open --interactive";
          }
          {
            on = ["d"];
            run = "remove --force";
          }
          {
            on = ["r"];
            run = "rename --force";
          }
          {
            on = ["f"];
            run = "find --smart";
          }
        ];
      };
    };
  };
}
