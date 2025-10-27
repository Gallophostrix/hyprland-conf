{inputs, ...}: {
  home-manager.sharedModules = [
    (_: {
      xdg.configFile."yazi/flavors/catppuccin-mocha.yazi".source = "${inputs.yazi-flavors}/catppuccin-mocha.yazi";

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
          /*
          preview = {
            # wrap = "yes";
            tab_size = 4;
            image_filter = "triangle"; # from fast to slow but high quality: nearest, triangle, catmull-rom, lanczos3
            max_width = 1920; # maybe 1000
            max_height = 1080; # maybe 1000
            # max_width = 1500;
            # max_height = 1500;
            image_quality = 90;
          };
          */
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
          };
          open = {
            prepend_rules = [
              {
                name = "*.pdf";
                use = "pdf";
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
              {
                name = "*.mp4";
                use = "video";
              }
              {
                name = "*.webm";
                use = "video";
              }
              {
                name = "*.txt";
                use = ["editor" "nano"];
              }
            ];
          };
        };
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
        theme = {
          flavor.dark = "catppuccin-mocha";
          flavor.light = "catppuccin-mocha";

          mgr = {
            border_symbol = " ";
          };
        };
      };
    })
  ];
}
