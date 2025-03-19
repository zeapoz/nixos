{
  pkgs,
  config,
  inputs,
  ...
}: let
  eww-scripts = inputs.eww-scripts.packages.${pkgs.system}.default;
in {
  home.packages = with pkgs; [
    jaq
    jc
    eww-scripts
  ];

  programs.eww = {
    enable = true;
    enableFishIntegration = true;
  };

  xdg.configFile = {
    "eww".source = config.lib.meta.mkMutableSymlink ./.;

    # TODO: Make available in eww.
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
