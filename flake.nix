{
  inputs = {
    nixpkgs.url = "nixpkgs";
  };

  outputs = inputs:
    let
      name = "kanata";
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      system = "x86_64-linux";
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = builtins.attrValues {
          inherit (pkgs)
            clippy
            nixpkgs-fmt
            rnix-lsp
            rust-analyzer
            rustfmt
            ;
        };
        inputsFrom = [
          inputs.self.packages.${system}.default
        ];
      };
      overlays.default = final: prev: {
        "${name}" = final.callPackage ./package.nix { };
      };
      packages.${system}.default =
        let
          pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = [
              inputs.self.overlays.default
            ];
          };
        in
        pkgs.${name};
    };
}
