{ config, pkgs, ...}:

{
  # Bootloader.
  boot = {
    supportedFilesystems = [ "ntfs" ];
    loader.grub.device = "/dev/sda";
    kernelPackages = pkgs.linuxPackages_latest;
    initrd.kernelModules = [ "amdgpu" ];
  };

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
