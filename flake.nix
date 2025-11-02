{
    description = "Practical Defensive Web Application System";

    inputs = {
           nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    };

    outputs = { self, nixpkgs, ... }:

            let
                system = "x86_64-linux";
                pkgs = nixpkgs.legacyPackages.${system};
		lib = pkgs.lib;
            in
            {
                packages.${system}.default = pkgs.buildGoModule {
                    pname = "valinor-one";
                    version = "0.1.0";
                    src = lib.cleanSource ./.;
                    vendorHash = null;
                    go = pkgs.go_1_22;
                };

                app.${system}.default = {
                    type = "app";
                    program = "${self.packages.${system}.default}/bin/valinor-one";
                };

                devShells.${system}.default = pkgs.mkShell{
                    buildInputs = [ pkgs.go_1_22 ];
                };
            };

}
