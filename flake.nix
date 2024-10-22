{
  description = "Some flakes";
  outputs = {self}: {
    templates = {
      raylib = {
        path = ./raylib;
        description = "A flake for raylib";
      };
      c = {
        path = ./c;
        description = "A flake for c";
      };
      "minecraft-mod-1.21.1" = {
        path = ./minecraft-mod-1.21.1;
        description = "A flake for a 1.21.1 minecraft mod";
      };
    };
  };
}
