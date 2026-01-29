{ lib, ... }:

let
  inherit (lib) types;
in
{
  options.flake.meta = lib.mkOption {
    type = types.attrsOf types.anything;
    default = {};
    description = "the flake's meta values, can be anything!";
  };
}
