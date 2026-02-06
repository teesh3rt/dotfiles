{...}: {
  flake.modules.nixos.base = {
    time.timeZone = "Asia/Jerusalem";

    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_IL";
      LC_IDENTIFICATION = "en_IL";
      LC_MEASUREMENT = "en_IL";
      LC_MONETARY = "en_IL";
      LC_NAME = "en_IL";
      LC_NUMERIC = "en_IL";
      LC_PAPER = "en_IL";
      LC_TELEPHONE = "en_IL";
      LC_TIME = "en_IL";
    };
  };
}
