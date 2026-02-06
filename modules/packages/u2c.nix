{...}: {
  perSystem = {pkgs, ...}: {
    packages.u2c = pkgs.stdenv.mkDerivation {
      name = "u2c";
      version = "2.19";

      src = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/9001/copyparty/6694998985e98326ca4ca0a0724cfd4901be2430/bin/u2c.py";
        hash = "sha256-IyYBB6yIIQB1FAFLs6xOw5+A09W+JKRj4FF/CwiFru0=";
      };
      dontUnpack = true;

      installPhase = ''
        mkdir -p $out/bin
        cp $src $out/bin/u2c
        chmod +x $out/bin/u2c
      '';

      buildInputs = [pkgs.python3];

      meta = {
        description = "A fast uploader for Copyparty";
        homepage = "https://github.com/9001/copyparty";
      };
    };
  };
}
