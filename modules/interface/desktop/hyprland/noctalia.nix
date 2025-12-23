{
  pkgs,
  inputs,
  ...
}: {
  programs.noctalia-shell = {
    enable = true;
    settings = {
      general = {
        avatarImage = "/mnt/data/Images/Affichage/Photo de profil/Gallophostrix.png";
        scaleRatio = 1;
        radiusRatio = 1;
        iRadiusRatio = 1;
        boxRadiusRatio = 1;
        screenRadiusRatio = 1;
        animationSpeed = 1;
        animationDisabled = false;
        compactLockScreen = false;
        lockOnSuspend = true;
        showSessionButtonsOnLockScreen = true;
        showHibernateOnLockScreen = false;
        enableShadows = true;
        shadowDirection = "bottom_right";
      };
      ui = {
        fontDefault = "Inter";
        fontFixed = "JetBrainsMono Nerd Font";
        fontDefaultScale = 1;
        fontFixedScale = 1;
        tooltipsEnabled = true;
        panelBackgroundOpacity = 0.85;
        panelsAttachedToBar = true;
        settingsPanelMode = "attached";
      };
      colorSchemes = {
        useWallpaperColors = true;
        predefinedScheme = "Noctalia (default)";
        darkMode = true;
        schedulingMode = "false";
        manualSunrise = "06:30";
        manualSunset = "22:30";
        matugenSchemeType = "scheme-content";
        generateTemplatesForPredefined = true; # check
      };
      templates = {
        # check
        gtk = false;
        qt = false;
        kcolorscheme = false;
        alacritty = false;
        kitty = false;
        ghostty = false;
        foot = false;
        wezterm = false;
        fuzzel = false;
        discord = false;
        pywalfox = false;
        vicinae = false;
        walker = false;
        code = false;
        spicetify = false;
        telegram = false;
        cava = false;
        yazi = true;
        emacs = false;
        niri = false;
        mango = false;
        zed = true;
        enableUserTemplates = true;
      };
      wallpaper = {
        enabled = true;
        overviewEnabled = false;
        directory = "/home/mik/nixcfg/modules/interface/wallpapers";
        monitorDirectories = [];
        enableMultiMonitorDirectories = true;
        recursiveSearch = true;
        setWallpaperOnAllMonitors = false;
        fillMode = "crop";
        fillColor = "#000000";
        randomEnabled = false;
        randomIntervalSec = 300;
        transitionDuration = 1500;
        transitionType = "random";
        transitionEdgeSmoothness = 0.05;
        panelPosition = "follow_bar";
        hideWallpaperFilenames = false;
        useWallhaven = false;
        wallhavenQuery = "";
        wallhavenSorting = "relevance";
        wallhavenOrder = "desc";
        wallhavenCategories = "111";
        wallhavenPurity = "100";
        wallhavenRatios = "";
        wallhavenResolutionMode = "atleast";
        wallhavenResolutionWidth = "";
        wallhavenResolutionHeight = "";
      };
      bar = {
        position = "top";
        monitors = [];
        density = "default";
        transparent = false;
        showCapsule = false;
        floating = true;
        marginVertical = 0.25;
        marginHorizontal = 0.25;
        widgets = {
          left = [
            {
              id = "ControlCenter";
              useDistroLogo = true;
            }
            {
              hideUnoccupied = false;
              id = "Workspace";
              labelMode = "index";
              followFocusedScreen = true;
            }
            {
              id = "MediaMini";
              hideWhenIdle = false;
              showAlbumArt = true;
              showArtistFirst = false;
              showVisualizer = true;
              visualizerType = "linear";
              showProgressRing = true;
              maxWidth = 150;
            }
          ];
          center = [
            {
              formatHorizontal = "HH:mm";
              formatVertical = "HH mm";
              id = "Clock";
              useMonospacedFont = false;
              usePrimaryColor = true;
            }
          ];
          right = [
            {
              id = "SystemMonitor";
              showCpuUsage = true;
              showCpuTemp = true;
              showGpuTemp = true;
              showMemoryUsage = true;
              showMemoryAsPercent = true;
            }
            {
              id = "WiFi";
            }
            {
              id = "VPN";
            }
            {
              id = "Bluetooth";
            }
            {
              id = "Volume";
            }
            {
              id = "Brightness";
            }
            {
              alwaysShowPercentage = false;
              id = "Battery";
              warningThreshold = 30;
            }
            {
              id = "NotificationHistory";
            }
          ];
        };
      };
      dock = {
        enabled = false;
        displayMode = "auto_hide";
        backgroundOpacity = 1;
        floatingRatio = 1;
        size = 1;
        onlySameOutput = true;
        monitors = [];
        pinnedApps = [];
        colorizeIcons = false;
        pinnedStatic = false;
        inactiveIndicators = false;
        deadOpacity = 0.6;
        animationSpeed = 1;
      };
      controlCenter = {
        position = "close_to_bar_button";
        shortcuts = {
          left = [
            {
              id = "WiFi";
            }
            {
              id = "Bluetooth";
            }
            {
              id = "ScreenRecorder";
            }
            {
              id = "WallpaperSelector";
            }
          ];
          right = [
            {
              id = "Notifications";
            }
            {
              id = "PowerProfile";
            }
            {
              id = "KeepAwake";
            }
            {
              id = "NightLight";
            }
          ];
        };
        cards = [
          {
            enabled = true;
            id = "profile-card";
          }
          {
            enabled = true;
            id = "shortcuts-card";
          }
          {
            enabled = true;
            id = "audio-card";
          }
          {
            enabled = false;
            id = "brightness-card";
          }
          {
            enabled = false;
            id = "weather-card";
          }
          {
            enabled = true;
            id = "media-sysmon-card";
          }
        ];
      };
      notifications = {
        enabled = true;
        monitors = [];
        location = "top_right";
        overlayLayer = true;
        backgroundOpacity = 1;
        respectExpireTimeout = false;
        lowUrgencyDuration = 3;
        normalUrgencyDuration = 8;
        criticalUrgencyDuration = 15;
        enableKeyboardLayoutToast = true;
        sounds = {
          enabled = false;
          volume = 0.5;
          separateSounds = false;
          criticalSoundFile = "";
          normalSoundFile = "";
          lowSoundFile = "";
          excludedApps = "discord,firefox,chrome,chromium,edge,brave";
        };
      };
      osd = {
        enabled = true;
        location = "top_right";
        autoHideMs = 2000;
        overlayLayer = true;
        backgroundOpacity = 1;
        enabledTypes = [
          0
          1
          2
          4
        ];
        monitors = [];
      };
      sessionMenu = {
        enableCountdown = true;
        countdownDuration = 10000;
        position = "center";
        showHeader = true;
        largeButtonsStyle = true;
        powerOptions = [
          {
            action = "lock";
            enabled = true;
          }
          {
            action = "suspend";
            enabled = true;
          }
          {
            action = "hibernate";
            enabled = false;
          }
          {
            action = "reboot";
            enabled = true;
          }
          {
            action = "logout";
            enabled = false;
          }
          {
            action = "shutdown";
            enabled = true;
          }
        ];
      };
      audio = {
        volumeStep = 2;
        volumeOverdrive = false;
        cavaFrameRate = 30;
        visualizerType = "linear";
        mprisBlacklist = [];
        preferredPlayer = "spotify";
        externalMixer = "pwvucontrol || pavucontrol";
      };
      brightness = {
        brightnessStep = 2;
        enforceMinimum = false;
        enableDdcSupport = true;
      };
      nightLight = {
        enabled = false;
        forced = false;
        autoSchedule = true;
        nightTemp = "4000";
        dayTemp = "6000";
        manualSunrise = "06:30";
        manualSunset = "22:30";
      };
      network = {
        wifiEnabled = true;
      };
      location = {
        monthBeforeDay = false;
        name = "Metz, France";
        weatherEnabled = true;
        weatherShowEffects = true;
        useFahrenheit = false;
        use12hourFormat = false;
        showWeekNumberInCalendar = false;
        showCalendarEvents = true;
        showCalendarWeather = true;
        analogClockInCalendar = false;
        firstDayOfWeek = -1;
      };
      calendar = {
        cards = [
          {
            enabled = true;
            id = "calendar-header-card";
          }
          {
            enabled = true;
            id = "calendar-month-card";
          }
          {
            enabled = true;
            id = "timer-card";
          }
          {
            enabled = true;
            id = "weather-card";
          }
        ];
      };
      screenRecorder = {
        directory = "/mnt/data/Images/Screenshots";
        frameRate = 60;
        audioCodec = "opus";
        videoCodec = "h264";
        quality = "very_high";
        colorRange = "limited";
        showCursor = true;
        audioSource = "default_output";
        videoSource = "portal";
      };
      systemMonitor = {
        cpuWarningThreshold = 80;
        cpuCriticalThreshold = 90;
        tempWarningThreshold = 80;
        tempCriticalThreshold = 90;
        gpuWarningThreshold = 80;
        gpuCriticalThreshold = 90;
        memWarningThreshold = 80;
        memCriticalThreshold = 90;
        diskWarningThreshold = 80;
        diskCriticalThreshold = 90;
        cpuPollingInterval = 3000;
        tempPollingInterval = 3000;
        gpuPollingInterval = 3000;
        enableNvidiaGpu = true;
        memPollingInterval = 3000;
        diskPollingInterval = 3000;
        networkPollingInterval = 3000;
        useCustomColors = false; # check
        warningColor = "";
        criticalColor = "";
      };
    };
    user-templates = ''
      [config]

      # Theme Alacritty terminal
      [templates.alacritty]
      input_path = "~/nixcfg/modules/interface/desktop/hyprland/noctalia-templates/alacritty.toml"
      output_path = "~/.config/alacritty/alacritty.toml"

      # Theme Hyprland compositor
      [templates.hyprland]
      input_path = "~/nixcfg/modules/interface/desktop/hyprland/noctalia-templates/hyprland.conf"
      output_path = "~/.config/hypr/hyprland.conf"
    '';
  };
}
