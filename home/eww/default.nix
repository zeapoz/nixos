{
  pkgs,
  config,
  inputs,
  ...
}:
let
  eww-scripts = inputs.eww-scripts.packages.${pkgs.system}.default;
in {
  home.packages = with pkgs; [
    eww
    jaq
    jc
    eww-scripts
  ];

  xdg.configFile = {
    "eww".source = config.lib.meta.mkMutableSymlink ./.;

    # TODO: Make these modules available in eww.
    # "eww/modules/battery.yuck".text =
    #   if osConfig.hardware.hasBattery
    #   then ''
    #     (deflisten battery "scripts/battery")
    #     (defwidget battery []
    #       (box :class "module battery ''${battery.class}"
    #             :orientation "v"
    #         (label :class "icon" :text "''${battery.icon}")
    #         (label :text "''${battery.percent}")))''
    #   else ''
    #     (defwidget battery []
    #       (box :visible false))'';
    #
    # "eww/modules/bar2.yuck".text =
    #   if (osConfig.networking.hostName == "helium")
    #   then ''
    #     (defwindow bar2
    #       :monitor 1
    #       :geometry (geometry 
    #         :x "0"
    #         :x "0"
    #         :width "2%"
    #         :height "100%";
    #         :anchor "center right")
    #       :stacking "fg"
    #       :exclusive true
    #       (bar-box))''
    #   else "";
  };
}
