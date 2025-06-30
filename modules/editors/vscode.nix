{
  config,
  pkgs,
  ...
}: {
  hm = {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium-fhs;
    };
  };
}
