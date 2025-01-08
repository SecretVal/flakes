{
  description = "An example glfw project";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin"];

      perSystem = {
        self',
        pkgs,
        ...
      }: let
        name = "gflfw-c";
        version = "0.1.0";
      in {
        devShells.default = pkgs.mkShell {
          inputsFrom = [self'.packages.default];
        };

        packages = {
          default = pkgs.stdenv.mkDerivation {
            inherit version;
            pname = name;
            src = ./.;

            buildInputs = with pkgs; [
              gcc
              glfw
              glew
            ];

            buildPhase = ''
              gcc -o ${name} main.c
            '';

            installPhase = ''
              mkdir -p $out/bin
              mv ${name} $out/bin
            '';
          };
        };
      };
    };
}