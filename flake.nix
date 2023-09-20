{
  inputs.nixpkgs.url = "nixpkgs/nixos-23.05";
  inputs.nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
  }: let
    system = "x86_64-linux";
    overlay-unstable = final: prev: {
      unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    };
    pkg-unstable = import nixpkgs-unstable;    
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ({
          config,
          pkgs,
          ...
        }: {nixpkgs.overlays = [overlay-unstable];})
        ./configuration.nix
      ];
    };
  };
}
