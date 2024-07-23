{pkgs, ...}:

{
  boot = {
    loader = {
      grub.enable = true;
      grub.device = "/dev/sda";
      grub.useOSProber = true;
    };
    supportedFilesystems = [ "ntfs" ];
    kernelPackages = pkgs.linuxPackages_latest;
    initrd = {
      kernelModules = [ "amdgpu" ];
      systemd.network.wait-online.enable = false;
    };
  };

  systemd.network.wait-online.enable = false;

  hardware.opengl = {
    enable = true;
    driSupport = true;
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
    ];
  };

  services = {
    xserver = {
      videoDrivers = [ "amdgpu" ];
    };
  };
}
