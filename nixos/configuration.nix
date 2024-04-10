# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz";
in
{
  imports = [
    ./hardware-configuration.nix
    (import "${home-manager}/nixos")
  ];

  system.stateVersion = "23.11";

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "vostro"; # Define your hostname.
  networking.networkmanager.enable = true;

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiVdpau
      libvdpau-va-gl
      intel-compute-runtime
    ];
  };

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
      xkbVariant = "";
      xkbOptions = "caps:ctrl_modifier";
      windowManager.bspwm.enable = true;
      displayManager.defaultSession = "none+bspwm";
      # displayManager.sddm.enable = true;
      videoDrivers = [ "intel" ];
    };
  };

  time.timeZone = "America/Mexico_City";
  i18n.defaultLocale = "en_US.UTF-8";

  qt = {
    enable = true;
    platformTheme = "gtk2";
    style = "gtk2";
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
    packageOverrides = pkgs: {
      vaapiIntel = pkgs.vaapiIntel.override {
        enableHybridCodec = true;
      };
    };
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
	    haskell.compiler.native-bignum.ghcHEAD
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
	    intel-gpu-tools
      qbittorrent
      drawio
      libreoffice
      mesa
      intel-media-driver
      gparted
      (pkgs.texlive.combine {
        inherit (pkgs.texlive)
          scheme-basic
          #amssymb
          ulem
          capt-of
          metafont
          latexmk
          amsmath
          amsfonts
          #latexsym
          cancel
          hyperref
          wrapfig
          #graphicx
          fancyhdr
          float
          #longtable
          multirow booktabs
          #multicol
          caption
          sidecap
          adjustbox
          parskip
          enumitem
          #tikz
          lipsum
          xcolor
          cite
          #square
          #numbers
          ragged2e
          import
          beamer; })
      (python311.withPackages(ps: with ps; [
        pygame
        pyright
        cryptography
        pycryptodome
        sympy
        numpy
        pwntools
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
	  ];
  };

  environment = {
    shellInit = ''xcape -e "Caps_Lock=Escape"'';
  };
  
  environment.systemPackages = with pkgs; [
    xcape
  ];

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
  # virtualisation.virtualbox.host = {
  #   enable = true;
  #   enableExtensionPack = true;
  # };

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
