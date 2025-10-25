{
  host,
  lib,
  pkgs,
  ...
}: let
  inherit
    (import ../../../hosts/${host}/variables.nix)
    browser
    terminal
    tuiFileManager
    kbdLayout
    kbdVariant
    defaultWallpaper
    ;
in {
  imports = [
    ../../themes/Catppuccin # Catppuccin GTK and QT themes
    ./programs/waybar
    ./programs/wlogout
    ./programs/rofi
    ./programs/hypridle
    ./programs/hyprlock
    ./programs/swaync
    ./programs/dunst
  ];

  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  systemd.user.services.hyprpolkitagent = {
    description = "Hyprpolkitagent - Polkit authentication agent";
    wantedBy = ["graphical-session.target"];
    wants = ["graphical-session.target"];
    after = ["graphical-session.target"];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };
  services.displayManager.defaultSession = "hyprland";

  programs.hyprland = {
    enable = true;
    # withUWSM = true;
  };

  home-manager.sharedModules = let
    inherit (lib) getExe getExe';
  in [
    (
      {config, ...}: {
        xdg.portal = {
          enable = true;
          extraPortals = with pkgs; [
            xdg-desktop-portal-gtk
            xdg-desktop-portal-hyprland
          ];
          xdgOpenUsePortal = true;
          configPackages = [config.wayland.windowManager.hyprland.package];
          config.common.default = ["hyprland" "gtk"];
          config.hyprland = {
            default = [
              "hyprland"
              "gtk"
            ];
            "org.freedesktop.impl.portal.OpenURI" = "gtk";
            "org.freedesktop.impl.portal.FileChooser" = "gtk";
            "org.freedesktop.impl.portal.Print" = "gtk";
          };
        };

        xdg.userDirs = {
          enable = true;
          createDirectories = true;
          documents = "$HOME/Documents";
          download = "$HOME/Downloads";
          music = "$HOME/Music";
          pictures = "$HOME/Pictures";
          videos = "$HOME/Videos";
        };

        home.packages = with pkgs; [
          swww
          hyprpicker
          cliphist
          wf-recorder
          grimblast
          slurp
          swappy
          libnotify
          brightnessctl
          networkmanagerapplet
          pamixer
          pavucontrol
          playerctl
          waybar
          wtype
          wl-clipboard
          xdotool
          yad
          # socat # for and autowaybar.sh
          # jq # for and autowaybar.sh
        ];

        xdg.configFile."hypr/icons" = {
          source = ./icons;
          recursive = true;
        };

        # Set wallpaper
        services.swww.enable = true;

        #test later systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];
        wayland.windowManager.hyprland = {
          enable = true;
          plugins = [
            # inputs.hyprland-plugins.packages.${pkgs.system}.hyprwinwrap
            # inputs.hyprsysteminfo.packages.${pkgs.system}.default
          ];
          systemd = {
            enable = true;
            variables = ["--all"];
          };
          settings = {
            "$mainMod" = "SUPER";
            "$term" = "${getExe pkgs.${terminal}}";
            "$editor" = "codium --ozone-platform-hint=auto --enable-features=WaylandWindowDecorations";
            "$fileManager" = "$term --class \"tuiFileManager\" -e ${tuiFileManager}";
            "$browser" = browser;
            "$CONTROL" = "CTRL";

            env = [
              "XDG_CURRENT_DESKTOP,Hyprland"
              "XDG_SESSION_DESKTOP,Hyprland"
              "XDG_SESSION_TYPE,wayland"
              "GDK_BACKEND,wayland,x11,*"
              "NIXOS_OZONE_WL,1"
              "ELECTRON_OZONE_PLATFORM_HINT,auto"
              "MOZ_ENABLE_WAYLAND,1"
              "OZONE_PLATFORM,wayland"
              "EGL_PLATFORM,wayland"
              "CLUTTER_BACKEND,wayland"
              "SDL_VIDEODRIVER,wayland"
              "QT_QPA_PLATFORM,wayland;xcb"
              "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
              "QT_QPA_PLATFORMTHEME,qt6ct"
              # "QT_AUTO_SCREEN_SCALE_FACTOR,1"
              "WLR_RENDERER_ALLOW_SOFTWARE,1"
              "LIBVA_DRIVER_NAME,iHD"
              "__GLX_VENDOR_LIBRARY_NAME,mesa"
            ];

            # ---- XWayland ----

            xwayland.force_zero_scaling = true;

            # ---- Ecosystem ----
            ecosystem = {
              no_update_news = true;
              no_donation_nag = true;
            };

            # ---- Mouse and touchpad config ----

            input = {
              kb_layout = "${kbdLayout},ru";
              kb_variant = "${kbdVariant},";
              repeat_delay = 275; # or 212
              repeat_rate = 35;
              numlock_by_default = true;

              follow_mouse = 1;

              touchpad.natural_scroll = true;

              tablet.output = "current";

              sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
              force_no_accel = false;
            };

            cursor = {
              enable_hyprcursor = true;
            };

            # ---- General configs ----

            general = {
              gaps_in = 4;
              gaps_out = 9;
              border_size = 2;
              "col.active_border" = "rgba(ca9ee6ff) rgba(f2d5cfff) 45deg";
              "col.inactive_border" = "rgba(b4befecc) rgba(6c7086cc) 45deg";
              resize_on_border = true;
              layout = "dwindle"; # dwindle or master
              # allow_tearing = true; # Allow tearing for games (use immediate window rules for specific games or all titles)
            };

            gesture = [
              "3, horizontal, workspace"
            ];

            group = {
              "col.border_active" = "rgba(ca9ee6ff) rgba(f2d5cfff) 45deg";
              "col.border_inactive" = "rgba(b4befecc) rgba(6c7086cc) 45deg";
              "col.border_locked_active" = "rgba(ca9ee6ff) rgba(f2d5cfff) 45deg";
              "col.border_locked_inactive" = "rgba(b4befecc) rgba(6c7086cc) 45deg";
            };

            layerrule = [
              "blur, rofi"
              "ignorezero, rofi"
              "ignorealpha 0.7, rofi"

              "blur, swaync-control-center"
              "blur, swaync-notification-window"
              "ignorezero, swaync-control-center"
              "ignorezero, swaync-notification-window"
              "ignorealpha 0.7, swaync-control-center"
              # "ignorealpha 0.8, swaync-notification-window"
              # "dimaround, swaync-control-center"
            ];

            decoration = {
              shadow.enabled = false;
              rounding = 10;
              dim_special = 0.3;
              blur = {
                enabled = true;
                special = true;
                size = 6; # 6
                passes = 2; # 3
                new_optimizations = true;
                ignore_opacity = true;
                xray = false;
              };
            };

            animations = {
              enabled = true;
              bezier = [
                "linear, 0, 0, 1, 1"
                "md3_standard, 0.2, 0, 0, 1"
                "md3_decel, 0.05, 0.7, 0.1, 1"
                "md3_accel, 0.3, 0, 0.8, 0.15"
                "overshot, 0.05, 0.9, 0.1, 1.1"
                "crazyshot, 0.1, 1.5, 0.76, 0.92"
                "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
                "fluent_decel, 0.1, 1, 0, 1"
                "easeInOutCirc, 0.85, 0, 0.15, 1"
                "easeOutCirc, 0, 0.55, 0.45, 1"
                "easeOutExpo, 0.16, 1, 0.3, 1"
              ];
              animation = [
                "windows, 1, 4, md3_decel, popin 60%"
                "border, 1, 10, default"
                "fade, 1, 3, md3_decel"
                # "workspaces, 1, 3.5, md3_decel, slide"
                "workspaces, 1, 3.5, easeOutExpo, slide"
                # "workspaces, 1, 7, fluent_decel, slidefade 15%"
                # "specialWorkspace, 1, 3, md3_decel, slidefadevert 15%"
                "specialWorkspace, 1, 3, md3_decel, slidevert"
              ];
            };

            # ---- Layout settings ----

            dwindle = {
              pseudotile = true;
              preserve_split = true;
            };

            master = {
              new_status = "master";
              new_on_top = true;
              mfact = 0.5;
            };

            # ---- Misc settings ----

            misc = {
              disable_hyprland_logo = true;
              mouse_move_focuses_monitor = true;
              swallow_regex = "^(Alacritty|kitty)$";
              enable_swallow = true;
              vfr = true; # always keep on
              vrr = 0; # enable variable refresh rate (0=off, 1=on, 2=fullscreen only, 3 = fullscreen games/media)
            };

            render = {
              direct_scanout = 2; # 0 = off, 1 = on, 2 = auto (on with content type ‘game’)
            };

            # ---- Keymaps ----

            binde = [
              # Resize windows

              "$mainMod SHIFT, right, resizeactive, 30 0"
              "$mainMod SHIFT, left, resizeactive, -30 0"
              "$mainMod SHIFT, up, resizeactive, 0 -30"
              "$mainMod SHIFT, down, resizeactive, 0 30"

              # Resize windows with hjkl keys

              # "$mainMod SHIFT, l, resizeactive, 30 0"
              # "$mainMod SHIFT, h, resizeactive, -30 0"
              # "$mainMod SHIFT, k, resizeactive, 0 -30"
              # "$mainMod SHIFT, j, resizeactive, 0 30"

              # Functional keybinds

              ",XF86MonBrightnessDown,exec,brightnessctl set 2%-"
              ",XF86MonBrightnessUp,exec,brightnessctl set +2%"
              ",XF86AudioLowerVolume,exec,pamixer -d 2"
              ",XF86AudioRaiseVolume,exec,pamixer -i 2"
            ];

            bind = let
              autoclicker = pkgs.callPackage ./scripts/autoclicker.nix {};
            in [
              # Keybinds help menu

              "$mainMod, comma, exec, ${./scripts/keybinds.sh}"

              # Windows

              "$mainMod, Q, exec, ${./scripts/dontkillsteam.sh}" # killactive, kill the window on focus
              "$mainMod, delete, exit" # kill hyperland session
              "$mainMod, W, togglefloating" # toggle the window on focus to float
              "$mainMod SHIFT, G, togglegroup" # toggle the window on focus to float
              "$mainMod, F, fullscreen" # toggle the window on focus to fullscreen
              "$mainMod, L, exec, hyprlock" # lock screen
              "$mainMod, backspace, exec, pkill -x wlogout || wlogout -b 4" # logout menu
              "$CONTROL, ESCAPE, exec, pkill waybar || waybar" # toggle waybar

              # Switch between windows in a floating workspace
              "$mainMod, tab, cyclenext"
              "$mainMod, tab, bringactivetotop"

              # Move focus with mainMod + arrow keys
              "$mainMod, left, movefocus, l"
              "$mainMod, right, movefocus, r"
              "$mainMod, up, movefocus, u"
              "$mainMod, down, movefocus, d"

              # Move active window around current workspace with mainMod + CTRL [←→↑↓]
              "$mainMod CTRL, left, movewindow, l"
              "$mainMod CTRL, right, movewindow, r"
              "$mainMod CTRL, up, movewindow, u"
              "$mainMod CTRL, down, movewindow, d"

              # NumPad workspaces
              "$mainMod,       code:87, workspace, 1"
              "$mainMod SHIFT, code:87, movetoworkspace, 1"
              "$mainMod CTRL,  code:87, movetoworkspacesilent, 1"
              "$mainMod,       code:88, workspace, 2"
              "$mainMod SHIFT, code:88, movetoworkspace, 2"
              "$mainMod CTRL,  code:88, movetoworkspacesilent, 2"
              "$mainMod,       code:89, workspace, 3"
              "$mainMod SHIFT, code:89, movetoworkspace, 3"
              "$mainMod CTRL,  code:89, movetoworkspacesilent, 3"
              "$mainMod,       code:83, workspace, 4"
              "$mainMod SHIFT, code:83, movetoworkspace, 4"
              "$mainMod CTRL,  code:83, movetoworkspacesilent, 4"
              "$mainMod,       code:84, workspace, 5"
              "$mainMod SHIFT, code:84, movetoworkspace, 5"
              "$mainMod CTRL,  code:84, movetoworkspacesilent, 5"
              "$mainMod,       code:85, workspace, 6"
              "$mainMod SHIFT, code:85, movetoworkspace, 6"
              "$mainMod CTRL,  code:85, movetoworkspacesilent, 6"
              "$mainMod,       code:79, workspace, 7"
              "$mainMod SHIFT, code:79, movetoworkspace, 7"
              "$mainMod CTRL,  code:79, movetoworkspacesilent, 7"
              "$mainMod,       code:80, workspace, 8"
              "$mainMod SHIFT, code:80, movetoworkspace, 8"
              "$mainMod CTRL,  code:80, movetoworkspacesilent, 8"
              "$mainMod,       code:81, workspace, 9"
              "$mainMod SHIFT, code:81, movetoworkspace, 9"
              "$mainMod CTRL,  code:81, movetoworkspacesilent, 9"
              "$mainMod,       code:90, workspace, 10"
              "$mainMod SHIFT, code:90, movetoworkspace, 10"
              "$mainMod CTRL,  code:90, movetoworkspacesilent, 10"

              # Move to the first empty workspace instantly with mainMod + ALT + [↓]
              "$mainMod ALT, down, workspace, empty"

              # Move active window around current workspace with mainMod + SHIFT + CTRL [HLJK]
              # "$mainMod SHIFT CTRL, H, movewindow, l"
              # "$mainMod SHIFT CTRL, L, movewindow, r"
              # "$mainMod SHIFT CTRL, K, movewindow, u"
              # "$mainMod SHIFT CTRL, J, movewindow, d"

              # Special workspaces (scratchpad)
              "$mainMod CTRL, S, movetoworkspacesilent, special"
              "$mainMod ALT, S, movetoworkspacesilent, special"
              "$mainMod, S, togglespecialworkspace,"

              # Move focus with mainMod + HJKL keys
              # "$mainMod, h, movefocus, l"
              # "$mainMod, l, movefocus, r"
              # "$mainMod, k, movefocus, u"
              # "$mainMod, j, movefocus, d"

              # Scroll through existing workspaces with mainMod + scroll
              "$mainMod, mouse_down, workspace, e+1"
              "$mainMod, mouse_up, workspace, e-1"

              # Go to workspace 6 and 7 with mouse side buttons
              "$mainMod, mouse:276, workspace, 5"
              "$mainMod, mouse:275, workspace, 6"
              "$mainMod SHIFT, mouse:276, movetoworkspace, 5"
              "$mainMod SHIFT, mouse:275, movetoworkspace, 6"
              "$mainMod CTRL, mouse:276, movetoworkspacesilent, 5"
              "$mainMod CTRL, mouse:275, movetoworkspacesilent, 6"

              # Applications/Programs

              "$mainMod, Return, exec, $term"
              "$mainMod, T, exec, $term"
              "$mainMod, D, exec, $fileManager"
              "$mainMod, C, exec, $editor"
              "$mainMod, B, exec, $browser"
              "$mainMod, M, exec, spotify"
              "$mainMod SHIFT, Y, exec, youtube-music"
              "$CONTROL ALT, DELETE, exec, $term -e '${getExe pkgs.btop}'" # System Monitor
              "$mainMod CTRL, C, exec, hyprpicker --autocopy --format=hex" # Colour Picker

              "$mainMod, A, exec, launcher drun" # launch desktop applications
              "$mainMod, SPACE, exec, launcher drun" # launch desktop applications
              "$mainMod SHIFT, W, exec, launcher wallpaper" # launch wallpaper switcher
              "$mainMod, E, exec, launcher emoji" # launch emoji picker
              "$mainMod SHIFT, T, exec, launcher tmux" # launch tmux sessions
              "$mainMod, G, exec, launcher games" # game launcher
              # "$mainMod, tab, exec, launcher window" # switch between desktop applications
              # "$mainMod, R, exec, launcher file" # brrwse system files
              "$mainMod ALT, K, exec, ${./scripts/keyboardswitch.sh}" # change keyboard layout
              "$mainMod, less, exec, swaync-client -t -sw" # swayNC panel
              "$mainMod CTRL, G, exec, ${./scripts/gamemode.sh}" # disable hypr effects for gamemode
              "$mainMod, V, exec, ${./scripts/ClipManager.sh}" # Clipboard Manager
              "$mainMod SHIFT, M, exec, ${./scripts/rofimusic.sh}" # online music

              # Screenshot/Screencapture
              "$mainMod SHIFT, R, exec, ${./scripts/screen-record.sh} a" # Screen Record (area select)
              "$mainMod CTRL, R, exec, ${./scripts/screen-record.sh} m" # Screen Record (monitor select)
              "$mainMod, P, exec, ${./scripts/screenshot.sh} s" # drag to snip an area / click on a window to print it
              "$CONTROL, P, exec, ${./scripts/screenshot.sh} sf" # frozen screen, drag to snip an area / click on a window to print it
              "$mainMod, Print, exec, ${./scripts/screenshot.sh} m" # print focused monitor
              "$mainMod ALT, P, exec, ${./scripts/screenshot.sh} p" # print all monitor outputs

              # Functional keybinds
              ",xf86Sleep, exec, systemctl suspend" # Put computer into sleep mode
              ",XF86AudioMicMute,exec,pamixer --default-source -t" # mute mic
              ",XF86AudioMute,exec,pamixer -t" # mute audio
              ",XF86AudioPlay,exec,playerctl play-pause" # Play/Pause media
              ",XF86AudioPause,exec,playerctl play-pause" # Play/Pause media
              ",xf86AudioNext,exec,playerctl next" # go to next media
              ",xf86AudioPrev,exec,playerctl previous" # go to previous media

              # ",xf86AudioNext,exec,${./scripts/MediaCtrl.sh} next" # go to next media
              # ",xf86AudioPrev,exec,${./scripts/MediaCtrl.sh} previous" # go to previous media
              # ",XF86AudioPlay,exec,${./scripts/MediaCtrl.sh} play-pause" # go to next media
              # ",XF86AudioPause,exec,${./scripts/MediaCtrl.sh} play-pause" # go to next media

              # Rebuild NixOS with a KeyBind
              "$mainMod, U, exec, $term -e rebuild"

              "$mainMod, F8, exec, kill $(cat /tmp/auto-clicker.pid) 2>/dev/null || ${lib.getExe autoclicker} --cps 40"
              # "$mainMod ALT, mouse:276, exec, kill $(cat /tmp/auto-clicker.pid) 2>/dev/null || ${lib.getExe autoclicker} --cps 60"

              # Visuals

              # Night Mode (lower value means warmer temp)
              "$mainMod, F9, exec, ${getExe pkgs.hyprsunset} --temperature 3500" # good values: 3500, 3000, 2500
              "$mainMod, F10, exec, pkill hyprsunset"
            ];
            bindm = [
              # Move/Resize windows with mainMod + LMB/RMB and dragging
              "$mainMod, mouse:272, movewindow"
              "$mainMod, mouse:273, resizewindow"
            ];

            binds = {
              workspace_back_and_forth = 0;
              #allow_workspace_cycles=1
              #pass_mouse_when_bound=0
            };

            windowrulev2 = [
              # --- TILING ---
              "tile, title:^(.*Godot.*)$"

              # --- OPACITY ---
              "opacity 0.80 0.80, class:^(kitty|alacritty|Alacritty|org.wezfurlong.wezterm)$"
              "opacity 0.80 0.80, class:^(nvim-wrapper)$"
              "opacity 0.90 0.90, class:^(Emacs)$"
              "opacity 0.90 0.90, class:^(gcr-prompter)$" # keyring prompt
              "opacity 0.90 0.90, title:^(Hyprland Polkit Agent)$" # polkit prompt
              "opacity 1.00 1.00, class:^(firefox)$"
              "opacity 0.90 0.90, class:^(Brave-browser)$"
              "opacity 0.80 0.80, class:^(org.gnome.Nautilus|thunar)$"
              "opacity 0.80 0.80, class:^(Steam|steam|steamwebhelper)$"
              "opacity 0.80 0.80, class:^(VSCodium|codium-url-handler|code|code-url-handler)$"
              "opacity 0.80 0.80, class:^(tuiFileManager|org.kde.dolphin|org.kde.ark|nwg-look|qt5ct|qt6ct|yad)$"
              "opacity 0.90 0.90, class:^(com.github.rafostar.Clapper)$" # Clapper-Gtk
              "opacity 0.80 0.80, class:^(com.github.tchx84.Flatseal|hu.kramo.Cartridges|com.obsproject.Studio|gnome-boxes)$"
              "opacity 0.90 0.90, class:^(discord|WebCord)$" # Discord/Electron
              "opacity 0.80 0.80, class:^(app.drey.Warp|net.davidotek.pupgui2|Signal|io.gitlab.theevilskeleton.Upscaler)$"
              "opacity 0.80 0.70, class:^(pavucontrol|org.pulseaudio.pavucontrol|blueman-manager|.blueman-manager-wrapped|nm-applet|nm-connection-editor|org.kde.polkit-kde-authentication-agent-1)$"

              # --- TAGS "games" ---
              "content game, tag:games"
              "tag +games, content:game"
              "tag +games, class:^(steam_app.*|steam_app_\\d+|gamescope|Waydroid|osu!)$"

              # --- FULLSCREEN behavior for 'games' & 'video' ---
              "syncfullscreen, tag:games"
              "fullscreen, tag:games"
              "noborder 1, tag:games"
              "noshadow, tag:games"
              "noblur, tag:games"
              "noanim, tag:games"

              "syncfullscreen, tag:video"
              "fullscreen, tag:video"
              "noborder, tag:video"
              "noshadow, tag:video"
              "noanim, tag:video"

              # --- General floats ---
              "float, class:^(qt5ct|nwg-look|org.kde.ark|Signal|com.github.rafostar.Clapper|app.drey.Warp|net.davidotek.pupgui2|eog|io.gitlab.theevilskeleton.Upscaler|yad|pavucontrol|blueman-manager|.blueman-manager-wrapped|nm-applet|nm-connection-editor|org.kde.polkit-kde-authentication-agent-1)$"
            ];

            # ---- Lauchers ----

            exec-once = let
              wallpaper = pkgs.callPackage ./scripts/wallpaper.nix {inherit defaultWallpaper;};
            in [
              # --- WS1 ---
              "[workspace 1 silent] ${browser}"

              # --- WS2 ---
              "[workspace 2 silent] ${terminal}"
              "[workspace 2 silent] $editor"

              # --- WS3
              "[workspace 3 silent] spotify"
              "[workspace 3 silent] alacritty -t Cava -e cava"

              #"[workspace special silent] ${browser} --private-window"
              #"[workspace special silent] ${terminal}"

              "sleep 0.5; hyprctl dispatch workspace 3"

              "${lib.getExe wallpaper}"
              "waybar"
              "swaync"
              "nm-applet --indicator"
              "wl-clipboard-history -t"
              "${getExe' pkgs.wl-clipboard "wl-paste"} --type text --watch cliphist store --no-newline" # clipboard store text data
              "${getExe' pkgs.wl-clipboard "wl-paste"} --type image --watch cliphist store" # clipboard store image data
              "rm '$XDG_CACHE_HOME/cliphist/db'" # Clear clipboard
              "${./scripts/batterynotify.sh}" # battery notification
              # "${./scripts/autowaybar.sh}" # uncomment packages at the top
              # "pamixer --set-volume 50"
            ];

            monitor = [
              # Easily plug in any monitor
              ",preferred,auto,1"

              # My Monitors
              "eDP-1,2560x1600@60,auto,1.3333334"
              "desc:BNQ BenQ EW277HDR 99J01861SL0,preferred,-1920x0,1"
              "desc:BNQ BenQ EL2870U PCK00489SL0,preferred,0x0,2"
              "desc:BNQ BenQ xl2420t 99D06760SL0,preferred,1920x-420,1,transform,1" # 5 for fipped
            ];

            workspace = [
              # Binds workspaces to my monitors (find desc with: hyprctl monitors)
              "1,monitor:desc:BNQ BenQ EL2870U PCK00489SL0,default:true"
              "2,monitor:desc:BNQ BenQ EL2870U PCK00489SL0"
              "3,monitor:desc:BNQ BenQ EL2870U PCK00489SL0"
              "4,monitor:desc:BNQ BenQ EL2870U PCK00489SL0"
              "5,monitor:desc:BNQ BenQ EW277HDR 99J01861SL0,default:true"
              "6,monitor:desc:BNQ BenQ EW277HDR 99J01861SL0"
              "7,monitor:desc:BNQ BenQ EW277HDR 99J01861SL0"
              "8,monitor:desc:BNQ BenQ xl2420t 99D06760SL0,default:true"
              "9,monitor:desc:BNQ BenQ xl2420t 99D06760SL0"
              "10,monitor:desc:BNQ BenQ EL2870U PCK00489SL0"
            ];
          };
        };
      }
    )
  ];
}
