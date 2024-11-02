{
  description = "Example kickstart Rust application project.";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin"];

      perSystem = {
        self',
        pkgs,
        ...
      }: let
        inherit (pkgs) dockerTools rustPlatform;
        inherit (dockerTools) buildImage;
        inherit (rustPlatform) buildRustPackage;
        buildInputs = with pkgs;
          [
            zstd
          ]
          ++ lib.optionals stdenv.hostPlatform.isLinux [
            alsa-lib
            libxkbcommon
            udev
            vulkan-loader
            wayland
            xorg.libX11
            xorg.libXcursor
            xorg.libXi
            xorg.libXrandr
          ]
          ++ lib.optionals stdenv.hostPlatform.isDarwin [
            darwin.apple_sdk_11_0.frameworks.Cocoa
            rustPlatform.bindgenHook
          ];
        name = "bevy";
        version = "0.1.0";
      in {
        devShells = {
          default = pkgs.mkShell {
            inputsFrom = [self'.packages.default];
            LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath buildInputs;
          };
        };

        packages = {
          default = buildRustPackage {
            inherit version;
            cargoHash = "sha256-sA07E0mZ9P6l/cKBmGhgZj2S7Pfz9IPXEj6/JogFFhU=";
            pname = name;
            src = ./.;
            nativeBuildInputs = with pkgs; [
              makeWrapper
              pkg-config
            ];
            inherit buildInputs;
          };

          docker = buildImage {
            inherit name;
            tag = version;
            config = {
              Cmd = ["${self'.packages.default}/bin/${name}"];
              Env = [
                "SSL_CERT_FILE=${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"
              ];
            };
          };
        };
      };
    };
}
