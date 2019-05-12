# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot.initrd.availableKernelModules = [ "ahci" "xhci_pci" "usb_storage" "sd_mod" "sdhci_acpi" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/12b07a6a-88c2-4a01-ba78-5c337a88b430";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/6E0C-33AA";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/f9fa2f59-5d9e-4270-b6cf-f9c109f573d4"; }
    ];

  boot.cleanTmpDir = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.extraConfig = "
	[General]
	Enable=Source,Sink,Media,Socket
  ";
  hardware.opengl.enable = true;
  hardware.cpu.intel.updateMicrocode = true;
  networking.hostName = "simyon";
  nix.maxJobs = lib.mkDefault 4;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
