{ pkgs, ...}:
let
  unstable = import <nixos-unstable> {
    config = {
      allowUnfree = true;
      };
    };
in
{
  networking = {
    hostName = "pcgei";
    networkmanager.enable = true;
  };

  time.timeZone = "America/Mexico_City";
  i18n.defaultLocale = "en_GB.UTF-8";

  console.keyMap = "us";

  users.defaultUserShell = pkgs.zsh;

  powerManagement.enable = true;

  environment.systemPackages = with pkgs; [
    busybox
    home-manager
    xcape
    htop
    git 
    gcc_multi
    gmp
    wget
    neovim 
    testdisk
    neofetch
    psmisc
    bc
    gparted
    unzipNLS
    p7zip
    gzip
    zip
    iproute2
    clang
    clang-tools
    libclang
    nettools
    xxd
  ];

  environment = {
    shellInit = ''xcape -e "Caps_Lock=Escape"'';
    variables = {
      EDITOR = "emacsclient";
      "QT_STYLE_OVERRIDE" = "kvantum";
    };
  };

  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
    extraConfig = "load-module module-combine-sink";
  };

  qt = {
    enable = true;
    # platformTheme = "gtk2";  # Set the platform theme
    # style.name = "kvantum";  # Use Kvantum style
    platformTheme = "qt5ct"; 
    style = "kvantum";
  };

  fonts = {
    packages = with pkgs; [
      office-code-pro
      fira-code-nerdfont
      (nerdfonts.override {
        fonts = [ "Iosevka" ];
      })
    ];
    fontconfig = {
      defaultFonts = {
        serif = [ "FiraCode Nerd Font" ];
      };
    };
  };

  nix.extraOptions = "sandbox = false";
  nixpkgs.config = {
    allowUnfree = true;
    pulseaudio = true;
  };

  programs = {
    light.enable = true;
    dconf.enable = true;
    virt-manager.enable = true;

    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };

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
  };

  services = {
    tlp.enable = true;
    logind.extraConfig = "HandlePowerKey=ignore";
    openssh.enable = true;
    gvfs.enable = true;
    tumbler.enable = true;


    displayManager.sddm = {
      enable = true;
    };

    xserver = {
      enable = true;
      xkb = {
        variant = ",dvorak";
        options = "caps:ctrl_modifier;compose:ralt";
        layout = "us";
      };
      windowManager.bspwm.enable = true;
    };

    picom = {
      enable = true;
      fade = true;
      #shadow = true;
      fadeDelta = 4;
    };

    emacs = {
      enable = true;
      package = pkgs.emacs29;
    };

    mysql = {
      enable = true;
      package = pkgs.mariadb;
    };

  };

  virtualisation = {
    libvirtd.enable = true;
    # virtualisation.vmware.host.enable = true;
    # virtualbox.host = {
    #   enable = true;
    #   #   enableExtensionPack = true;
    # };
  };

  users.users.jellu = {
    isNormalUser = true;
    description = "Jellu Cat";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "audio"
                    "video" "libvirtd"
                    "user-with-access-to-virtualbox"];
    packages = with pkgs; [];
  };

}
