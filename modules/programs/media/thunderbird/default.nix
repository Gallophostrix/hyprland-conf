{inputs, ...}: let
  extensions = [
    # Theme
    "${inputs.thunderbird-catppuccin}/themes/mocha/mocha-mauve.xpi"
    # "https://addons.thunderbird.net/thunderbird/downloads/latest/dracula-theme-for-thunderbird/addon-987962-latest.xpi"
    # "https://addons.thunderbird.net/thunderbird/downloads/latest/luminous-matter/addon-988120-latest.xpi"
    # "https://addons.thunderbird.net/thunderbird/downloads/latest/dark-black-theme/addon-988343-latest.xpi"

    # "https://addons.thunderbird.net/thunderbird/downloads/latest/grammar-and-spell-checker/addon-988138-latest.xpi"
    # "https://addons.thunderbird.net/thunderbird/downloads/latest/external-editor-revived/addon-988342-latest.xpi"
  ];
in {
  programs.thunderbird = {
    enable = true;
    policies = {
      Extensions.Install = extensions;
    };
    preferences = {
      "privacy.donottrackheader.enabled" = true;
      # "mailnews.start_page.enabled" = false;
      # "mail.chat.enabled" = false;
      "mail.phishing.detection.enabled" = true;
      "mail.inline_attachments" = true;

      "mailnews.default_sort_order" = 2;

      "mail.spellcheck.inline" = true;

      "mail.biff.show_alert" = true;
      "mail.biff.use_system_alert" = true;
    };
  };
}
