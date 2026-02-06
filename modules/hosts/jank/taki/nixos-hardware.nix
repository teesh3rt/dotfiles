{...}: {
  flake.modules.nixos.taki = {
    pkgs,
    config,
    ...
  }: {
    hardware.firmware = [pkgs.sof-firmware];

    hardware.bluetooth.enable = true;

    hardware.graphics.extraPackages = with pkgs; [
      intel-media-driver
      intel-compute-runtime
      vpl-gpu-rt
    ];
    services.fstrim.enable = true;
    services.tlp.enable = !config.services.power-profiles-daemon.enable;

    boot = {
      # Workaround: Out of the box, resuming from hibernation will break sounds.
      #             See https://gitlab.freedesktop.org/pulseaudio/pulseaudio/-/issues/766
      extraModprobeConfig = ''
        options snd-hda-intel model=generic
        options snd-hda-intel snd-intel-dspcfg.dsp_driver=1
        blacklist snd_soc_skl
      '';

      kernelParams = [
        # Workaround: i915 0000:00:02.0: [drm] *ERROR* Atomic update failure on pipe A
        #             See https://www.dedoimedo.com/computers/intel-microcode-atomic-update.html
        "i915.enable_psr=0"

        # Workaround: Seems like guc on VT-d is faulty and may also cause GUC: TLB invalidation response timed out.
        #             It will cause random gpu resets under hw video decoding.
        #             See https://wiki.archlinux.org/title/Dell_XPS_16_(9640)#Random_freezes
        "iommu.strict=1"
        "iommu.passthrough=1"

        # Workaround: i915 0000:00:02.0: [drm] *ERROR* [CRTC:82:pipe A] flip_done timed out
        #             See https://github.com/pop-os/pop/issues/3130
        "i915.dmc_firmware_path=\"\""
      ];
    };

    environment.variables = {
      INTEL_DEBUG = "no32";
    };

    security.tpm2.enable = true;

    hardware.enableRedistributableFirmware = true;
    hardware.i2c.enable = true;

    services = {
      fwupd.enable = true;
      hardware.bolt.enable = true;
      thermald.enable = true;
    };
  };
}
