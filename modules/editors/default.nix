{pkgs, ...}: {
  hm = {
    packages = with pkgs; [zed-editor-fhs];

    programs.vscode.enable = true;
  };
}
