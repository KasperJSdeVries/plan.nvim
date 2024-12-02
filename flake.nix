{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
      };

      nativeBuildInputs = with pkgs; [
        lua
      ];

    in {
      devShells.default = pkgs.mkShell {
        inherit nativeBuildInputs;
        packages = with pkgs; [
          nil
          lua-language-server
        ];
      };

      formatter = pkgs.alejandra;
    });
}
