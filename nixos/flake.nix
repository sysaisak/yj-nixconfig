{
  description = "ai";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }:
    let
      system = "x86_64-linux";

      profile = {
        user = "c0mbo";
        hostName = "yuanjiao";
        timeZone = "America/Bogota";
        desktop = "xfce";
        defaultShell = "zsh";

        locale = {
          default = "en_US.UTF-8";
          extra = [
            "es_CO.UTF-8/UTF-8"
            "zh_CN.UTF-8/UTF-8"
            "en_US.UTF-8/UTF-8"
          ];
        };

        services = {
          ssh = true;
          steam = true;
          podman = true;
          virtualization = true;
          tor = true;
        };

        gpu = {
          nvidia = true;
          prime = true;
          nvidiaBusId = "PCI:1:0:0";
          amdgpuBusId = "PCI:6:0:0";
        };
      };

      specialArgs = {
        inherit profile;
      };
    in
    {
      nixosConfigurations.${profile.hostName} = nixpkgs.lib.nixosSystem {
        inherit system specialArgs;

        modules = [
          ./system/core.nix
          ./system/hardware.nix
          ./system/desktop.nix
          ./system/services.nix
          ./system/packages.nix
	  ./system/virtualization.nix
          ./hardware-configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.${profile.user} = import ./home-manager/home.nix;

            home-manager.extraSpecialArgs = specialArgs;
          }
        ];
      };
    };
}
