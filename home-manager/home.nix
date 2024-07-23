{ lib, config, pkgs, ...}:

# let
#  unstable = import inputs.nixpkgs-unstable {
#    system = pkgs.system;
#  };
# in
{
  home.username = "jellu";
  home.homeDirectory = "/home/jellu";
  home.stateVersion = "24.05";
  home.enableNixpkgsReleaseCheck = true;

  nixpkgs.config.allowUnfree = true;

  home.sessionVariables = {
    BASH_DIR = "repos/dotfiles/bash";
    ZSH_DIR = "repos/dotfiles/zsh";
  };
  
  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    initExtra = ''source ~/$ZSH_DIR/.zshrc'';
  };

  programs.bash = {
    enable = true;
    bashrcExtra = ''
        source ~/$BASH_DIR/.bashrc
        source ~/$BASH_DIR/.bash_aliases
        source ~/$BASH_DIR/.bash_logout
	'';
    profileExtra = ''
        source ~/$BASH_DIR/.profile
  '';
  };

  home.packages = with pkgs; [
    feh
    firefox
    chromium
    krita
    gimp
    inkscape-with-extensions
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
    wmctrl
    srandrd
    arandr
    copyq
    networkmanagerapplet
    xdotool
    stalonetray
    xorg.xwininfo
    # intel-gpu-tools
    qbittorrent
    drawio
    libreoffice
    mesa
    # intel-media-driver
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
    wirelesstools
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    dynamips
    vpcs
    libarchive
    maltego
    xournalpp
    blender
    brave
    # rsbkb
    swiProlog
    losslesscut-bin
    obs-studio
    klavaro
    xdg-desktop-portal
    exiftool
    arp-scan
    eza
    ripgrep
    # rich-cli
    radeontop
    nvtop-amd
    xdg-desktop-portal
    ryujinx
    bat
    # mysql-workbench
    zoom-us
    squirrel-sql
    sequeler
    dbeaver-bin
  ];

  home.file = {
    ".local/bin" = {
      source = "${config.home.homeDirectory}/repos/scripts/bin";
      recursive = true;
    };
    ".config" = {
      source = "${config.home.homeDirectory}/repos/dotfiles/.config";
      recursive = true;
    };
   ".config/emacs" = {
      source = "${config.home.homeDirectory}/repos/emacs";
      recursive = true;
   }; 
   ".config/nvim" = {
      source = "${config.home.homeDirectory}/repos/nvim";
      recursive = true;
   }; 
  };


  # xsession.windowManager.bspwm = {
  #   enable = true;
  #   extraConfig = lib.fileContents ~/repos/dotfiles/bspwm/bspwmrc;
  # };

  # # deprecated
  # programs.git = {
  #   enable = true;
  #   extraConfig = lib.fileContents ~/repos/dotfiles/git/config;
  #   # extraConfig = toString (lib.fileContents ~/repos/dotfiles/git/config);
  #   # extraConfig = lib.strings.splitString "\n" (lib.fileContents ~/repos/dotfiles/git/config);
  # };

  # programs.mpv = {
  #   enable = true;
  #   config = lib.fileContents ~/repos/dotfiles/mpv/mpv.conf;
  # };

}
