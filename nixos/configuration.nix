{ config, pkgs, ... }:

let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz";
  oracle-xe-url = pkgs.fetchurl {
    url = "https://download.oracle.com/otn-pub/otn_software/db-express/oracle-database-xe-21c-1.0-1.ol8.x86_64.rpm";
    sha256 = "f8357b432de33478549a76557e8c5220ec243710ed86115c65b0c2bc00a848db";
  };
in
{
  imports = [
    ./hardware-configuration.nix
    (import "${home-manager}/nixos")
  ];

  system.stateVersion = "23.11";

  networking.hostName = "vostro"; # Define your hostname.
  networking.networkmanager.enable = true;

  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
    extraConfig = "load-module module-combine-sink";
  };

  console.keyMap = "la-latin1";

  powerManagement.enable = true;
  services = {
    tlp.enable = true;
    logind.extraConfig = "HandlePowerKey=ignore";
    xserver = {
      enable = true;
      layout = "latam";
      xkbVariant = ",dvorak";
      xkbOptions = "caps:ctrl_modifier";
      windowManager.bspwm.enable = true;
      displayManager.sddm = {
        enable = true;
      };
    };
  };

  time.timeZone = "America/Mexico_City";
  i18n.defaultLocale = "en_US.UTF-8";

  qt = {
    enable = true;
    # platformTheme = "gtk2";  # Set the platform theme
    # style.name = "kvantum";  # Use Kvantum style
    platformTheme = "qt5ct"; 
    style = "kvantum";
  };

  fonts.packages = with pkgs; [
    office-code-pro
    fira-code-nerdfont
    (nerdfonts.override {
      fonts = [ "Iosevka" ];
    })
  ];
  fonts.fontconfig = {
    defaultFonts = {
      serif = [ "FiraCode Nerd Font" ];
    };
  };

  nix.extraOptions = "sandbox = false";
  nixpkgs.config = {
    allowUnfree = true;
    pulseaudio = true;
    # packageOverrides = pkgs: {
    # vaapiIntel = pkgs.vaapiIntel.override {
    # enableHybridCodec = true;
    # };
    # };
  };

  programs = {
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
    light.enable = true;
    dconf.enable = true;
    virt-manager.enable = true;
    zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      enableCompletion = true;
      ohMyZsh = {
        enable = true;
        plugins = [ "git"
                    "thefuck"
                    "sudo"
                    "history"
                    "history-substring-search"];
        theme = "gallifrey";
      };
    };
    steam.enable = true;
  };

  # sudo chown -R jellu:users /nix
  # sudo -u jellu nix-env -iE 'p: {}'
  # sudo chown -R root:users /nix

  users.users.jellu = {
    isNormalUser = true;
    description = "Jellu Cat";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "audio"
                    "video" "libvirtd"
                    "user-with-access-to-virtualbox"];
    packages = with pkgs; [
    	git 
      gcc_multi
      gmp
	    wget
	    neovim 
	    testdisk
	    feh
	    firefox
	    chromium
	    wget
	    krita
      gimp
	    inkscape-with-extensions
	    neofetch
	    nodejs
	    mpv
      open-in-mpv
      mpvScripts.sponsorblock
      mpvScripts.uosc
	    polybar
	    rofi
	    sxhkd
      nsxiv
	    kitty
	    redshift
	    haskell.compiler.ghc948
      pkgs.haskell-language-server
      cabal-install
	    htop
	    wmctrl
	    psmisc
	    srandrd
	    arandr
	    copyq
	    networkmanagerapplet
	    xdotool
	    stalonetray
	    xorg.xwininfo
	    bc
	    # intel-gpu-tools
      qbittorrent
      drawio
      libreoffice
      mesa
      # intel-media-driver
      gparted
      (python311.withPackages(ps: with ps; [
        pygame
        pyright
        cryptography
        pycryptodome
        sympy
        numpy
        pwntools
        chardet
      ]))
      flameshot
      sioyek
      mictray
      pavucontrol
      discord
      telegram-desktop
      whatsapp-for-linux
      unzipNLS
      p7zip
      gzip
      zip
      typescript
      nodePackages_latest.typescript-language-server
      palemoon-bin
      typst
      pandoc
      typstfmt
      typst-lsp
      ghidra
      xorg.xev
      usbutils
      vscode
      github-desktop
      open-vm-tools
      nmap
      nettools
      hashcat
      john
      glxinfo
      pciutils
      clinfo
      libva-utils
      starship
      thefuck
      metasploit
      lsof
      kazam
      imagemagick
      mediainfo
      ffmpeg
      xrestop
      wezterm
      mcomix
      yt-dlp
      prismlauncher
      pamixer
      iproute2
      wirelesstools
      libsForQt5.qtstyleplugin-kvantum
      libsForQt5.qt5ct
      dynamips
      vpcs
      clang
      clang-tools
      libclang
      libarchive
      maltego
      xournalpp
      blender
      brave
      rsbkb
      swiProlog
      losslesscut-bin
      obs-studio
      klavaro
      xdg-desktop-portal
      exiftool
      xxd
      arp-scan
      nettools
      eza
      ripgrep
      rich-cli
      radeontop
      nvtop-amd
      xdg-desktop-portal
	  ];
  };

  environment = {
    shellInit = ''xcape -e "Caps_Lock=Escape"'';
  };
  
  environment.systemPackages = with pkgs; [
    xcape
    # oracle-xe
  ];


  environment.variables = {
    EDITOR = "emacsclient";
    "QT_STYLE_OVERRIDE" = "kvantum";
  };

  services = {
    # xcape.enable = true;
    picom = {
      enable = true;
      fade = true;
      #shadow = true;
      fadeDelta = 4;
    };
    gvfs.enable = true;
    tumbler.enable = true;
    emacs = {
      enable = true;
      package = pkgs.emacs29;
    };
  };

  virtualisation.libvirtd.enable = true;
  # virtualisation.vmware.host.enable = true;
  virtualisation.virtualbox.host = {
    enable = true;
    #   enableExtensionPack = true;
  };

  ## dconf.settings = {
  ##   "org/virt-manager/virt-manager/connections" = {
  ##     autoconnect = ["qemu:///system"];
  ##     uris = ["qemu:///system"];
  ##   };
  ## };

  # For me, it's better to have home-manager as a standalone program
  # nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz home-manager
  # nix-channel --update
  # nix-shell '<home-manager>' -A install

  # home-manager.users.jellu = {
  #   home.stateVersion = "23.11";
  #   home.packages = with pkgs; [
  #     cbonsai
  #   ];
  # };

}