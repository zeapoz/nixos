{pkgs, ...}: let
  configPath = "$HOME/.config/ranger";
  iconRepo = "https://github.com/alexanderjeurissen/ranger_devicons";
  iconPath = "${configPath}/plugins/ranger_devicons";
in {
  config.hm = {
    packages = with pkgs; [ranger];

    programs.fish.shellAliases.r = "ranger";

    configFile."ranger/rc.conf".text = ''
      set preview_images true
      set preview_images_method kitty

      default_linemode devicons
    '';

    user.home.activation = {
      installIconPlugin = ''
        if [ ! -d "${iconPath}" ]; then
           git clone "${iconRepo}" "${iconPath}"
        fi
      '';
    };
  };
}
