{
  description = "@teesh3rt's configuration flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";

    import-tree.url = "github:vic/import-tree";

    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:nix-community/stylix/release-25.11";
    stylix.inputs.nixpkgs.follows = "nixpkgs";

    lazyvim = {
      url = "github:pfassina/lazyvim-nix";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; }
    (inputs.import-tree ./modules);
}
