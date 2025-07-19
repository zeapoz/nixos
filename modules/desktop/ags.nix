{inputs, ...}: {
  hm = {
    user.imports = [
      inputs.ags.homeManagerModules.default
    ];

    programs.ags.enable = true;
  };
}
