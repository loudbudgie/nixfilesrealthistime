
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./filesystems.nix
    ];

# hardware services
hardware.graphics = {
	enable = true;
	enable32Bit = true;
};

hardware.bluetooth.enable = true;
hardware.usb-modeswitch.enable = true;
# hardware.new-lg4ff.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_6_18;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # Enable networking
  networking.networkmanager.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
# services.xserver.enable = true;

# Enable the KDE Desktop Environment.
    services.desktopManager.plasma6.enable = false;
    services.displayManager.sddm = {
	enable = false;
	wayland.enable = true;
    };
    services.displayManager.plasma-login-manager.enable = false;

# Enable the GNOME desktop environment
services.displayManager.gdm.enable = true;
services.desktopManager.gnome.enable = true;
services.gnome.core-apps.enable = false;
services.gnome.core-developer-tools.enable = false;
services.gnome.games.enable = false;
environment.gnome.excludePackages = with pkgs; [ gnome-tour gnome-user-docs nautilus ];
  # Configure keymap in X11
 # services.xserver.xkb = {
#    layout = "us";
#    variant = "";
 # };

# Define services
  # Enable CUPS to print documents.
  services.printing.enable = true;
services.avahi = {
	enable = true;
	nssmdns4 = true;
	openFirewall = true;
};
services.displayManager.ly.enable = false;
services.gnome.gnome-keyring.enable = true;
services.flatpak.enable = true;
  # thunar stuff
  services.gvfs.enable = true; # mount, trash, and more
  services.tumbler.enable = true; # thumbnail support for images
services.power-profiles-daemon.enable = true;

# services.blueman.enable = true;

# services.udisks2.enable = true;

# xdg.portal.extraPortals = with pkgs; [
#   xdg-desktop-portal-wlr
#   xdg-desktop-portal-gtk
# ];   

# security services I guess
security.polkit.enable = true;
# security.pam.services.swaylock = {};

virtualisation.libvirtd.enable = true;
virtualisation.spiceUSBRedirection.enable = true;

# Systemd services

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this:
    # jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    # media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.immutaboy = {
    isNormalUser = true;
    description = "immutaboy";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "video" "render" "input"];
    shell = pkgs.fish;
    packages = with pkgs; [
    #  thunderbird
    ];
  };

# Define packages with programs.enable
programs.firefox.enable = true;
programs.thunderbird.enable = true;

programs.virt-manager.enable = true;

programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
#    package = pkgs.steam.override {
#	extraArgs = "-cef-disable-gpu";
 #   };
};

programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-gstreamer
        obs-vkcapture
    ];
};

# programs.gnupg.agent.enable = true;

# programs.niri.enable = true;

programs.fish.enable = true;

programs.thunar.enable = true;
programs.xfconf.enable = true;
programs.thunar.plugins = with pkgs; [
	thunar-archive-plugin
	thunar-volman
];

nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
gnupg
git
neovim
fastfetch
prismlauncher
mission-center
ristretto
file-roller # archive manager that works with thunar
htop
bibata-cursors
papirus-icon-theme
kitty
ranger
playerctl
kdePackages.kdenlive
haruna
# jstest-gtk
tty-clock
mangohud
gimp
pavucontrol
kara
inkscape
oversteer
pfetch
kdePackages.kate
# kdePackages.qt6ct
gnomeExtensions.arcmenu
gnomeExtensions.clipboard-indicator
gnomeExtensions.appindicator


# WM
wl-clipboard
#swaybg
#rofi
#fuzzel
#swaylock
#xwayland-satellite
# quickshell
# xdg-utils
nwg-look
xeyes
# hyprpolkitagent
# orchis-theme

# Proprietary codecs
ffmpeg-full
dav1d
  ];

fonts.packages = with pkgs; [
	nerd-fonts.jetbrains-mono
	nerd-fonts.fira-code
	fira
	adwaita-fonts
	ibm-plex
];

fonts.fontconfig.defaultFonts = {
    sansSerif = [ "IBM Plex Sans" ];
};

nix.settings.experimental-features = [ "nix-command" "flakes" ];


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

# Automounting a non-boot drive
fileSystems."/mnt/MoreGames" = {
  device = "/dev/disk/by-uuid/e2803d8e-8015-4774-ac74-8cdfd46fc550";
  fsType = "ext4";
  options = [ "defaults" "nofail" ];
};

zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 25;
};

services.btrfs.autoScrub = {
  enable = true;
  interval = "monthly";
  fileSystems = [ "/" ];
};

services.snapper = {
  configs = {
    root = {
      SUBVOLUME = "/";
      ALLOW_USERS = [ "immutaboy" ];
      TIMELINE_CREATE = true;
      TIMELINE_CLEANUP = true;
      # limits for timeline cleanup
      TIMELINE_LIMIT_HOURLY = 3;
      TIMELINE_LIMIT_DAILY = 4;
      TIMELINE_LIMIT_WEEKLY = 0;
      TIMELINE_LIMIT_MONTHLY = 2;
      TIMELINE_LIMIT_YEARLY = 0;
    };
    home = {
      SUBVOLUME = "/home";
      ALLOW_USERS = [ "immutaboy" ]; # List of users allowed to operate with the config. “root” is always implicitly included.
      TIMELINE_CREATE = true; # Defines whether hourly snapshots should be created.
      TIMELINE_CLEANUP = true; # Defines whether the timeline cleanup algorithm should be run for the config.
      TIMELINE_LIMIT_HOURLY = 2;
      TIMELINE_LIMIT_DAILY = 1;
      TIMELINE_LIMIT_WEEKLY = 0;
      TIMELINE_LIMIT_MONTHLY = 0;
      TIMELINE_LIMIT_YEARLY = 0;
    };
  };
  snapshotInterval = "hourly";
  cleanupInterval = "1h";
  persistentTimer = true; # Set the Persistent option for the systemd.timer(5) which triggers the snapshot immediately if the last trigger was missed (e.g. if the system was powered down).
  snapshotRootOnBoot = false; # Whether to snapshot root on boot
};


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  # system.stateVersion = "25.11"; # Did you read the comment?
  system.stateVersion = "26.05"; # yes

}
