{...}: {
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
        lockScreenAnimations = true;
        lockOnSuspend = true;
        showSessionButtonsOnLockScreen = true;
        showHibernateOnLockScreen = false;
        enableLockScreenCountdown = true;
        enableLockScreenMediaControls = true;
        enableShadows = true;
        shadowDirection = "bottom_right";
        autoStartAuth = true;
        clockStyle = "custom";
        clockFormat = "hh:mm";
        passwordChars = true;
        allowPanelsOnScreenWithoutBar = true;
        allowPasswordWithFprintd = false;
        forceBlackScreenCorners = false;
        lockScreenCountdownDuration = 10000;
        lockScreenMonitors = [];
        lockScreenTint = 0;
        reverseScroll = false;
        shadowOffsetX = 2;
        shadowOffsetY = 3;
        showChangelogOnStartup = true;
        showScreenCorners = false;
        enableBlurBehind = true;
        dimmerOpacity = 0.2;
        lockScreenBlur = 0.2;
        telemetryEnabled = false;
        language = "";
        smoothScrollEnabled = true;
      };
      ui = {
        boxBorderEnabled = false;
        scrollbarAlwaysVisible = true;
        settingsPanelSideBarCardStyle = false;
        translucentWidgets = false;
        fontDefault = "DejaVu Sans";
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
        monitorForColors = "";
        darkMode = true;
        schedulingMode = "off";
        manualSunrise = "06:30";
        manualSunset = "22:30";
        generationMethod = "content";
        syncGsettings = true;
      };
      templates = {
        enableUserTheming = true;
        activeTemplates = [
          {
            id = "alacritty";
            enabled = false;
          }
          {
            id = "ghostty";
            enabled = true;
          }
          {
            id = "gtk";
            enabled = true;
          }
          {
            id = "qt";
            enabled = true;
          }
          {
            id = "spicetify";
            enabled = true;
          }
          {
            id = "steam";
            enabled = true;
          }
          {
            id = "yazi";
            enabled = false;
          }
          {
            id = "zathura";
            enabled = true;
          }
          {
            id = "zed";
            enabled = true;
          }
        ];
      };
      wallpaper = {
        enabled = true;
        overviewEnabled = false;
        directory = "/home/mik/nixcfg/modules/interface/wallpapers";
        monitorDirectories = [];
        enableMultiMonitorDirectories = true;
        viewMode = "recursive";
        setWallpaperOnAllMonitors = true;
        fillMode = "crop";
        fillColor = "#000000";
        automationEnabled = true;
        wallpaperChangeMode = "random";
        randomIntervalSec = 300;
        transitionDuration = 1500;
        transitionType = [
          "fade"
          "disc"
          "stripes"
          "wipe"
          "honeycomb"
        ];
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
        sortOrder = "name";
        linkLightAndDarkWallpapers = true;
      };
      bar = {
        position = "top";
        monitors = [];
        density = "default";
        showCapsule = false;
        barType = "floating";
        marginVertical = 5;
        marginHorizontal = 5;
        widgets = {
          left = [
            {
              id = "ControlCenter";
              useDistroLogo = true;
              colorizeDistroLogo = false;
              colorizeSystemIcon = "none";
              colorizeSystemText = "none";
              customIconPath = "";
              enableColorization = false;
              icon = "noctalia";
            }
            {
              id = "Workspace";
              labelMode = "index";
              followFocusedScreen = true;
              hideUnoccupied = false;
              characterCount = 2;
              colorizeIcons = false;
              emptyColor = "secondary";
              enableScrollWheel = true;
              focusedColor = "primary";
              fontWeight = "bold";
              groupedBorderOpacity = 1;
              iconScale = 0.8;
              occupiedColor = "secondary";
              pillSize = 0.6;
              showApplications = false;
              showApplicationsHover = false;
              showBadge = true;
              showLabelsOnlyWhenOccupied = true;
              unfocusedIconsOpacity = 1;
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
              compactMode = false;
              hideMode = "hidden";
              panelShowAlbumArt = true;
              scrollingMode = "hover";
              textColor = "none";
              useFixedWidth = false;
            }
          ];
          center = [
            {
              id = "plugin:screen-recorder";
            }
            {
              id = "Clock";
              formatHorizontal = "HH:mm";
              formatVertical = "HH mm";
              tooltipFormat = "HH:mm ddd, MMM dd";
              clockColor = "none";
              useCustomFont = false;
              customFont = "";
            }
            {
              id = "NotificationHistory";
              showUnreadBadge = true;
              unreadBadgeColor = "primary";
              hideWhenZero = false;
              hideWhenZeroUnread = false;
              iconColor = "none";
            }
          ];
          right = [
            {
              id = "SystemMonitor";
              compactMode = true;
              showCpuUsage = true;
              showCpuTemp = true;
              showGpuTemp = true;
              showMemoryUsage = true;
              showMemoryAsPercent = true;
              useMonospaceFont = true;
              diskPath = "/";
              iconColor = "none";
              showCpuCores = false;
              showCpuFreq = false;
              showDiskAvailable = false;
              showDiskUsage = false;
              showDiskUsageAsPercent = false;
              showLoadAverage = false;
              showNetworkStats = false;
              showSwapUsage = false;
              textColor = "none";
              usePadding = false;
            }
            {
              id = "Network";
              displayMode = "onhover";
              iconColor = "none";
              textColor = "none";
            }
            {id = "plugin:tailscale";}
            {
              id = "Bluetooth";
              displayMode = "onhover";
              iconColor = "none";
              textColor = "none";
            }
            {
              id = "Volume";
              displayMode = "onhover";
              middleClickCommand = "pwvucontrol || pavucontrol";
              iconColor = "none";
              textColor = "none";
            }
            {
              id = "Brightness";
              displayMode = "onhover";
              applyToAllMonitors = false;
              iconColor = "none";
              textColor = "none";
            }
            {
              id = "Battery";
              displayMode = "graphic-clean";
              hideIfNotDetected = true;
              showPowerProfiles = true;
              deviceNativePath = "__default__";
              hideIfIdle = false;
              showNoctaliaPerformance = false;
            }
            {id = "plugin:usb-drive-manager";}
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
      desktopWidgets = {
        enabled = true;
        overviewEnabled = true;
        monitorWidgets = [
          {
            name = "eDP-1";
            widgets = [
              {
                id = "AudioVisualizer";
                showBackground = true;
                roundedCorners = true;
                width = 900;
                height = 320;
                x = 920;
                y = 800;
                visualizerType = "mirrored";
                hideWhenIdle = false;
                colorName = "primary";
              }
            ];
          }
        ];
      };
      controlCenter = {
        position = "close_to_bar_button";
        shortcuts = {
          left = [
            {
              id = "Network";
            }
            {
              id = "Bluetooth";
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
      appLauncher = {
        enableClipboardHistory = true;
        terminalCommand = "ghostty -e";
        autoPasteClipboard = false;
        clipboardWatchImageCommand = "wl-paste --type image --watch cliphist store";
        clipboardWatchTextCommand = "wl-paste --type text --watch cliphist store";
        clipboardWrapText = true;
        customLaunchPrefix = "";
        customLaunchPrefixEnabled = false;
        density = "default";
        enableClipPreview = true;
        enableClipboardChips = true;
        enableClipboardSmartIcons = true;
        enableSessionSearch = true;
        enableSettingsSearch = true;
        enableWindowsSearch = true;
        iconMode = "tabler";
        ignoreMouseInput = false;
        overviewLayer = false;
        pinnedApps = [];
        position = "center";
        screenshotAnnotationTool = "";
        showCategories = true;
        showIconBackground = false;
        sortByMostUsed = true;
        viewMode = "list";
      };
      notifications = {
        enabled = true;
        enableMarkdown = true;
        monitors = [];
        clearDismissed = true;
        density = "default";
        enableBatteryToast = true;
        enableMediaToast = false;
        location = "top_right";
        overlayLayer = true;
        backgroundOpacity = 1;
        respectExpireTimeout = false;
        lowUrgencyDuration = 3;
        normalUrgencyDuration = 8;
        criticalUrgencyDuration = 15;
        enableKeyboardLayoutToast = true;
        saveToHistory = {
          low = false;
          normal = true;
          critical = true;
        };
        sounds = {
          enabled = false;
          volume = 0.5;
          separateSounds = false;
          criticalSoundFile = "";
          normalSoundFile = "";
          lowSoundFile = "";
          excludedApps = "brave";
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
        showKeybinds = false;
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
          {
            action = "rebootToUefi";
            enabled = false;
          }
        ];
      };
      idle = {
        enabled = true;
        screenOffTimeout = 600;
        lockTimeout = 360;
        suspendTimeout = 0;
        fadeDuration = 10;
      };
      audio = {
        volumeStep = 2;
        volumeOverdrive = false;
        volumeFeedback = false;
        volumeFeedbackSoundFile = "";
        spectrumFrameRate = 30;
        spectrumMirrored = true;
        visualizerType = "linear";
        mprisBlacklist = [];
        preferredPlayer = "spotify";
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
        bluetoothAutoConnect = true;
        bluetoothDetailsViewMode = "grid";
        bluetoothHideUnnamedDevices = false;
        bluetoothRssiPollIntervalMs = 60000;
        bluetoothRssiPollingEnabled = false;
        disableDiscoverability = false;
        networkPanelView = "wifi";
        wifiDetailsViewMode = "grid";
      };
      location = {
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
            id = "weather-card";
          }
        ];
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
        enableDgpuMonitoring = true;
        useCustomColors = false;
        warningColor = "";
        criticalColor = "";
      };
      noctaliaPerformance = {
        disableDesktopWidgets = true;
        disableWallpaper = true;
      };
      plugins = {
        autoUpdate = false;
        notifyUpdates = true;
      };
      hooks = {
        enabled = false;
        colorGeneration = "";
        darkModeChange = "";
        performanceModeDisabled = "";
        performanceModeEnabled = "";
        screenLock = "";
        screenUnlock = "";
        session = "";
        startup = "";
        wallpaperChange = "";
      };
    };
    user-templates = ''
      [config]

      # Theme Hyprland compositor
      [templates.hyprland]
      input_path = "~/nixcfg/modules/interface/desktop/hyprland/noctalia-templates/hyprland.conf"
      output_path = "~/.config/hypr/hyprland-noctalia.conf"
    '';
    plugins = {
      sources = [
        {
          enabled = true;
          name = "Official Noctalia Plugins";
          url = "https://github.com/noctalia-dev/noctalia-plugins";
        }
      ];
      states = {
        keybind-cheatsheet = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        tailscale = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        screen-recorder = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        usb-drive-manager = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
      };
      version = 2;
    };
  };
}
