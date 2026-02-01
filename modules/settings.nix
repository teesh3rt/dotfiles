{ ... }:

rec {
  flake.meta.user = {
    name = "teesh";
    email = "ilaylevy611@gmail.com";
    face = ./assets/face.png;
  };

  flake.meta.git.name = "teesh3rt";

  flake.meta.location = "/home/${flake.meta.user.name}/dotfiles";
  flake.meta.stateVersion = "25.11";
}
