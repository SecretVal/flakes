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
    };
  };
}
