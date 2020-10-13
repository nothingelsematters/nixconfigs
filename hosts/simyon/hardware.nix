{ lib, pkgs, ... }:

let sources = import ../../nix/sources.nix;
in {
  imports =
    [ "${sources.nixpkgs}/nixos/modules/installer/scan/not-detected.nix" ];

  boot = {
    initrd.availableKernelModules =
      [ "ahci" "xhci_pci" "usb_storage" "sd_mod" "sdhci_acpi" ];
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
    cleanTmpDir = true;

    loader.systemd-boot.enable = true;
    plymouth.enable = true;
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/12b07a6a-88c2-4a01-ba78-5c337a88b430";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/6E0C-33AA";
      fsType = "vfat";
    };
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/f9fa2f59-5d9e-4270-b6cf-f9c109f573d4"; }];

  hardware = {
    bluetooth = {
      enable = true;
      config.General.Enable = "Source,Sink,Media,Socket";
    };

    opengl = {
      enable = true;
      driSupport32Bit = true;
    };

    cpu.intel.updateMicrocode = true;

    enableAllFirmware = true;

    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
      support32Bit = true;
    };
  };

  networking.hostName = "simyon";
  nix.maxJobs = lib.mkDefault 4;
  powerManagement.cpuFreqGovernor = lib.mkDefault "performance"; # TODO test
}
