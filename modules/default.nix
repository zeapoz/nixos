{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  # FIXME: Remove config.nix filter.
  imports = lib.filter (n: !lib.strings.hasInfix "config.nix" n && !lib.strings.hasInfix "modules/default.nix" n && lib.strings.hasSuffix ".nix" n) (lib.filesystem.listFilesRecursive (builtins.toString ./.));
in {
  inherit imports;

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    builders-use-substitutes = true;
    substituters = [
      "https://hyprland.cachix.org"
      "https://anyrun.cachix.org"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  # Bootloader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot/efi";
    };

    # Kernel.
    kernelPackages = pkgs.linuxPackages_latest;
    extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];

    # Plymouth.
    initrd.systemd.enable = true;
    plymouth = {
      enable = true;
      theme = "square_hud";
      themePackages = with pkgs; [
        # By default we would install all themes
        (adi1090x-plymouth-themes.override {
          selected_themes = ["square_hud"];
        })
      ];
    };

    # Enable "Silent boot"
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];
    loader.timeout = 0;
  };

  # Hardware.
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sv_SE.utf8";
    LC_IDENTIFICATION = "sv_SE.utf8";
    LC_MEASUREMENT = "sv_SE.utf8";
    LC_MONETARY = "sv_SE.utf8";
    LC_NAME = "sv_SE.utf8";
    LC_NUMERIC = "sv_SE.utf8";
    LC_PAPER = "sv_SE.utf8";
    LC_TELEPHONE = "sv_SE.utf8";
    LC_TIME = "en_US.utf8";
  };

  # Japanese IME.
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [fcitx5-mozc fcitx5-gtk];
    fcitx5.waylandFrontend = true;
  };

  security.sudo.wheelNeedsPassword = false;

  # Enable sound with pipewire.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${config.user.name} = {
    isNormalUser = true;
    description = "${config.user.name}";
    extraGroups = [
      "networkmanager"
      "wheel"
      "input"
      "uinput"
      "audio"
      "adbusers"
      "libvirtd"
    ];
  };

  # Enable automatic login for the user.
  services.getty.autologinUser = "${config.user.name}";

  programs.adb.enable = true;
  virtualisation.libvirtd.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    gcc
    gnumake
    git
    htop
    vim
    virt-manager
  ];

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      fira
      fira-code
      fira-code-symbols
      font-awesome
      nerd-fonts.fira-code
      noto-fonts-cjk-sans
    ];
  };

  # Use fish as the default user shell
  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;

  programs.dconf.enable = true;
  programs.nix-ld.enable = true;

  # Syncing.
  hm.services.syncthing.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # https://github.com/NixOS/nixpkgs/issues/180175
  systemd.services.NetworkManager-wait-online.enable = false;
  systemd.services.systemd-networkd-wait-online.enable = false;

  networking = {
    # Enable networking.
    networkmanager.enable = true;

    # Setup wireguard for mullvad-vpn.
    firewall.checkReversePath = "loose";
    wireguard.enable = true;
  };

  services.mullvad-vpn.enable = true;
}
