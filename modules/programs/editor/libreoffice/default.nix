{pkgs, ...}: {
  home.packages = with pkgs; [
    libreoffice
    hunspellDicts.en_US
    hunspellDicts."fr-moderne"
    hunspellDicts.ru_RU
    hyphen
    mythes
    noto-fonts
    noto-fonts-emoji
  ];

  xdg.configFile."libreoffice/4/user/registrymodifications.xcu" = {
    force = true;
    text = ''
      <?xml version="1.0" encoding="UTF-8"?>
      <oor:items xmlns:oor="http://openoffice.org/2001/registry">
        <item oor:path="/org.openoffice.Office.Common/Locale">
          <prop oor:name="GeneralLocale"><value>fr_FR</value></prop>
        </item>
        <item oor:path="/org.openoffice.Office.Calc/Calculate">
          <prop oor:name="DefaultMeasurementUnit"><value>Centimeter</value></prop>
        </item>
        <item oor:path="/org.openoffice.Office.Common/View">
          <prop oor:name="MenuIcons"><value>true</value></prop>
        </item>
        <item oor:path="/org.openoffice.Office.Common/Misc">
          <prop oor:name="SymbolStyle" oor:op="fuse"><value>colibre_dark</value></prop>
        </item>
        <item oor:path="/org.openoffice.Office.UI.ToolbarMode">
          <prop oor:name="ActiveCalc" oor:op="fuse"><value>notebookbar.ui</value></prop>
        </item>
        <item oor:path="/org.openoffice.Office.UI.ToolbarMode">
          <prop oor:name="ActiveDraw" oor:op="fuse"><value>notebookbar.ui</value></prop>
        </item>
        <item oor:path="/org.openoffice.Office.UI.ToolbarMode">
          <prop oor:name="ActiveImpress" oor:op="fuse"><value>notebookbar.ui</value></prop>
        </item>
        <item oor:path="/org.openoffice.Office.UI.ToolbarMode">
          <prop oor:name="ActiveWriter" oor:op="fuse"><value>notebookbar.ui</value></prop>
        </item>
        <item oor:path="/org.openoffice.Office.UI.ToolbarMode/Applications/org.openoffice.Office.UI.ToolbarMode:Application['Calc']">
          <prop oor:name="Active" oor:op="fuse"><value>notebookbar.ui</value></prop>
        </item>
        <item oor:path="/org.openoffice.Office.UI.ToolbarMode/Applications/org.openoffice.Office.UI.ToolbarMode:Application['Draw']">
          <prop oor:name="Active" oor:op="fuse"><value>notebookbar.ui</value></prop>
        </item>
        <item oor:path="/org.openoffice.Office.UI.ToolbarMode/Applications/org.openoffice.Office.UI.ToolbarMode:Application['Impress']">
          <prop oor:name="Active" oor:op="fuse"><value>notebookbar.ui</value></prop>
        </item>
        <item oor:path="/org.openoffice.Office.UI.ToolbarMode/Applications/org.openoffice.Office.UI.ToolbarMode:Application['Writer']">
          <prop oor:name="Active" oor:op="fuse"><value>notebookbar.ui</value></prop>
        </item>
      </oor:items>
    '';

    # Additional extensions may be installed, such as WritingTools and AltSearch, using:
    # xdg.dataFile."libreoffice/extensions/LanguageTool.oxt".source = pkgs.fetchurl { url = ".../LanguageTool-<ver>.oxt"; sha256 = "<hash>"; };
  };
}
