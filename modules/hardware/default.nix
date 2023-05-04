{ pkgs, ... }:

{
  imports = [ ./bluetooth.nix ./keychron.nix ];

  hm.packages = with pkgs; [ kanata ];
}
