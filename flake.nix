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
      examplemod = {
        path = ./examplemod;
        description = "An example minecraft fabric mod";
      };
      bevy-example = {
        path = ./bevy-example;
        description = "An example bevy project";
      };
      glfw-c = {
        path = ./glfw-c;
        description = "An example glfw project";
      };
    };
  };
}
