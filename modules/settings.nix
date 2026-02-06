{...}: rec {
  flake.meta.user = {
    name = "teesh";
    email = "ilaylevy611@gmail.com";
    face = ./assets/face.png;
  };

  flake.meta.git.name = "teesh3rt";

  flake.meta.irc = {
    server = {
      name = "bouncer";
      addr = "192.168.1.200";
      port = 6667;
      isBouncer = true;
    };
    password = "password";
  };

  flake.meta.web.domain = {
    has = true;
    domain = "teesh.dev";
  };

  flake.meta.location = "/home/${flake.meta.user.name}/dotfiles";
  flake.meta.stateVersion = "25.11";
}
