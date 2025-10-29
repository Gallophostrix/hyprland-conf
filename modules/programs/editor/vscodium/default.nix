{ pkgs, ... }:
{
  home-manager.sharedModules = [
    (_: {
      programs.vscode = {
        enable = true;
        mutableExtensionsDir = true;
        package = pkgs.vscodium;
        profiles.default = {
          extensions = with pkgs.vscode-extensions; [
            # --- Workflow ---
            # eamodio.gitlens
            # github.vscode-github-actions

            # --- Formatting ---
            charliermarsh.ruff
            redhat.vscode-yaml
            jnoortheen.nix-ide
            yzhang.markdown-all-in-one
            tamasfe.even-better-toml
            # rust-lang.rust-analyzer
            # ms-python.python

            # --- Tools ---
            esbenp.prettier-vscode
            christian-kohler.path-intellisense

            # --- Themes ---
            catppuccin.catppuccin-vsc
            catppuccin.catppuccin-vsc-icons
          ];

          keybindings = [
            {
              key = "ctrl+q";
              command = "editor.action.commentLine";
              when = "editorTextFocus && !editorReadonly";
            }
            {
              key = "ctrl+s";
              command = "workbench.action.files.saveFiles";
            }
          ];
          userSettings = {
            # --- General ---
            "workbench.startupEditor" = "none";
            "update.mode" = "none";
            "extensions.autoCheckUpdates" = false;
            "extensions.autoUpdate" = false;
            "window.restoreWindows" = "none";

            "telemetry.telemetryLevel" = "off";
            "security.workspace.trust.untrustedFiles" = "open";

            # --- Workflow ---
            "terminal.integrated.inheritEnv" = true;
            "explorer.confirmDragAndDrop" = false;

            "editor.codeActionsOnSave" = {
              "source.sortImports" = "explicit";
              "source.fixAll.ruff" = "explicit";
            };
            "editor.formatOnSave" = true;
            "editor.formatOnType" = false;
            "editor.formatOnPaste" = true;

            "breadcrumbs.enabled" = true;
            "workbench.layoutControl.enabled" = false;

            "workbench.editor.limit.enabled" = true;
            "workbench.editor.limit.value" = 10;
            "workbench.editor.limit.perEditorGroup" = true;
            "explorer.openEditors.visible" = 1;

            "path-intellisense.autoSlashAfterDirectory" = true;
            "path-intellisense.extensionOnImport" = true;
            "path-intellisense.showHiddenFiles" = false;

            # --- Visuals ---
            "window.titleBarStyle" = "custom";
            "window.menuBarVisibility" = "classic";
            # "window.zoomLevel" = 0.5;
            "editor.fontSize" = 14;
            "editor.wordWrap" = "on";

            "editor.semanticHighlighting.enabled" = true;
            "editor.inlineSuggest.enabled" = true;
            "editor.stickyScroll.enabled" = true;
            "editor.renderControlCharacters" = false;
            "editor.mouseWheelZoom" = true;

            "editor.minimap.enabled" = false;
            "workbench.sideBar.location" = "left";
            # "workbench.activityBar.location" = "hidden";
            # "workbench.editor.showTabs" = "single";
            # "workbench.statusBar.visible" = false;
            "workbench.layoutControl.type" = "menu";

            "editor.scrollbar.verticalScrollbarSize" = 2;
            "editor.scrollbar.horizontalScrollbarSize" = 2;
            "editor.scrollbar.vertical" = "auto";
            "editor.scrollbar.horizontal" = "auto";

            "workbench.colorTheme" = "Catppuccin Mocha";
            "workbench.iconTheme" = "catppuccin-mocha";
            "catppuccin.accentColor" = "mauve";
            # "vsicons.dontShowNewVersionMessage" = false;
            "editor.fontLigatures" = true;

            "git.enableSmartCommit" = true;
            "git.autofetch" = true;
            "git.confirmSync" = false;
            # "gitlens.hovers.annotations.changes" = false;
            # "gitlens.hovers.avatars" = false;

            "[javascript]" = {
              "editor.defaultFormatter" = "esbenp.prettier-vscode";
            };
            "[typescript]" = {
              "editor.defaultFormatter" = "esbenp.prettier-vscode";
            };
            "[json]" = {
              "editor.defaultFormatter" = "esbenp.prettier-vscode";
            };
            "[html]" = {
              "editor.defaultFormatter" = "esbenp.prettier-vscode";
            };
            "[css]" = {
              "editor.defaultFormatter" = "esbenp.prettier-vscode";
            };
            "[markdown]" = {
              "editor.defaultFormatter" = "esbenp.prettier-vscode";
            };

            # --- Language config ---
            "[python]" = {
              "editor.defaultFormatter" = "charliermarsh.ruff";
              "editor.formatOnSave" = true;
            };
            "ruff.enable" = true;

            "[yaml]" = {
              "editor.defaultFormatter" = "redhat.vscode-yaml";
            };
            "yaml.format.enable" = true;
            "yaml.validate" = true;
            "yaml.schemaStore.enable" = true;

            "[nix]" = {
              "editor.defaultFormatter" = "jnoortheen.nix-ide";
            };
            "nix.formatterPath" = "alejandra";
            "nix.enableLanguageServer" = true;
            "nix.serverPath" = "nixd";
            "nix.serverSettings" = {
              "nixd" = {
                "formatting" = {
                  "command" = [ "alejandra" ];
                };
              };
            };

            "markdown.extension.toc.updateOnSave" = true;
            "markdown.extension.list.indentationSize" = "inherit";
            "markdown.preview.doubleClickToSwitchToEditor" = false;

            "[toml]" = {
              "editor.defaultFormatter" = "tamasfe.even-better-toml";
            };
            "evenBetterToml.formatter.alignEntries" = true;
          };
        };
      };
    })
  ];
}
