{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  imports = lib.filter (n: !lib.strings.hasInfix "modules/default.nix" n && lib.strings.hasSuffix ".nix" n) (lib.filesystem.listFilesRecursive (builtins.toString ./.));
in {
  inherit imports;

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    builders-use-substitutes = true;
    substituters = [
      "https://hyprland.cachix.org"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
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

  time.timeZone = "Europe/Stockholm";
  i18n = {
    defaultLocale = "en_US.UTF-8";

    extraLocaleSettings = {
      LC_ADDRESS = "sv_SE.UTF-8";
      LC_IDENTIFICATION = "sv_SE.UTF-8";
      LC_MEASUREMENT = "sv_SE.UTF-8";
      LC_MONETARY = "sv_SE.UTF-8";
      LC_NAME = "sv_SE.UTF-8";
      LC_NUMERIC = "sv_SE.UTF-8";
      LC_PAPER = "sv_SE.UTF-8";
      LC_TELEPHONE = "sv_SE.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };

    # Japanese IME.
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5.addons = with pkgs; [fcitx5-mozc fcitx5-gtk];
      fcitx5.waylandFrontend = true;
    };
  };

  security = {
    sudo.wheelNeedsPassword = false;
    # Enable sound with pipewire.
    rtkit.enable = true;
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

  virtualisation.libvirtd.enable = true;

  environment.systemPackages = with pkgs; [
    gcc
    git
    gnumake
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
      maple-mono.NF
      maple-mono.truetype
      maple-mono.variable
      nerd-fonts.fira-code
      noto-fonts-cjk-sans
      roboto
    ];
  };

  # Use fish as the default user shell
  users.defaultUserShell = pkgs.fish;

  programs = {
    adb.enable = true;
    fish.enable = true;
    nix-ld.enable = true;
    dconf.enable = true;
  };

  # Syncing.
  hm.services.syncthing.enable = true;

  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };

    devmon.enable = true;
    gvfs.enable = true;
    udisks2.enable = true;

    preload.enable = true;

    mullvad-vpn.enable = true;
  };

  # https://github.com/NixOS/nixpkgs/issues/180175
  systemd.services.NetworkManager-wait-online.enable = false;
  systemd.services.systemd-networkd-wait-online.enable = false;

  networking = {
    firewall.enable = false;

    # Enable networking.
    networkmanager.enable = true;

    # Setup wireguard for mullvad-vpn.
    firewall.checkReversePath = "loose";
    wireguard.enable = true;
  };
}
