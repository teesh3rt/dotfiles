{...}: {
  perSystem = {
    self',
    pkgs,
    lib,
    ...
  }: {
    packages.notion-app = pkgs.writeShellScriptBin "notion-app" ''
      ${lib.getExe pkgs.chromium} --app=https://www.notion.so
    '';

    packages.notion-icon = pkgs.stdenv.mkDerivation {
      name = "notion-icon";

      src = pkgs.fetchurl {
        url = "https://upload.wikimedia.org/wikipedia/commons/e/e9/Notion-logo.svg";
        hash = "sha256-G1KhhdgWbZM59cFt1ReJ7jD0mmW01Ac4KQtgQj4zEWA=";
      };
      dontUnpack = true;

      installPhase = ''
        mkdir -p $out/share/icons/hicolor/scalable/apps
        install -Dm664 $src $out/share/icons/hicolor/scalable/apps/notion.svg
      '';
    };

    packages.notion-desktop-item = pkgs.makeDesktopItem {
      name = "Notion";
      exec = "${self'.packages.notion-app}/bin/notion-app";
      icon = "notion";
      comment = "Productivity software";
      desktopName = "Notion";
      genericName = "Productivity software";
      categories = ["Office"];
    };

    packages.notion = pkgs.symlinkJoin {
      name = "notion";
      paths = with self'.packages; [
        notion-app
        notion-icon
        notion-desktop-item
      ];
    };

    apps.notion = {
      type = "app";
      program = "${self'.packages.notion}/bin/notion-app";
    };
  };
}
