{
  inputs = {
    # from https://github.com/lopsided98/nix-ros-overlay
    nix-ros-overlay.url = "github:lopsided98/nix-ros-overlay/master";
    nixpkgs.follows = "nix-ros-overlay/nixpkgs";  # IMPORTANT!!!
    gepettopkgs.url = "github:Gepetto/nixpkgs/hpp";
  };
  outputs = { self, nix-ros-overlay, nixpkgs, gepettopkgs }:
    nix-ros-overlay.inputs.flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ nix-ros-overlay.overlays.default ];
        };
        geppkgs = import gepettopkgs {
          inherit system;
        };
      in {
        devShells.default = pkgs.mkShell {
          name = "AGIMUS humble";
          # buildInputs = [
          #   # (pkgs.callPackage ./pkgs/colmpc/default.nix {})
          #   (pkgs.callPackage ./pkgs/colmpc/default.nix {})
          # ];
          packages = [
            # Basic build system for ROS
            pkgs.colcon
            
            # Local packages:
            (pkgs.callPackage ./pkgs/gepetto-viewer-corba/packages.nix {})
            (pkgs.callPackage ./pkgs/hpp-constraints/packages.nix {})
            (pkgs.callPackage ./pkgs/hpp-core/packages.nix {})
            (pkgs.callPackage ./pkgs/hpp-manipulation/packages.nix {})
            (pkgs.callPackage ./pkgs/hpp-manipulation-urdf/packages.nix {})
            (pkgs.callPackage ./pkgs/hpp-pinocchio/packages.nix {})
            (pkgs.callPackage ./pkgs/hpp-statistics/packages.nix {})
            (pkgs.callPackage ./pkgs/hpp-template-corba/packages.nix {})
            (pkgs.callPackage ./pkgs/colmpc/packages.nix {})


            # # Python packages:
            # (pkgs.python3.withPackages(p: [
            #   # Development tools
            #   p.ipython
            #   # Gepetto/Inria packages.
            #   p.crocoddyl
            #   # p.mim_solvers
            #   p.proxsuite
            # ]))
            
            # # Gepetto packages from fork
            # (geppkgs.python3.withPackages(p: [
            #   p.hpp-tutorial
            #   p.hpp-corbaserver
            #   p.hpp-environments
            #   p.hpp-gepetto-viewer
            #   p.hpp-manipulation-corba
            #   p.hpp-universal-robot
            # ]))
            # # geppkgs.hpp-bin-picking
            # geppkgs.gepetto-viewer-corba
            # geppkgs.hpp-constraints
            # geppkgs.hpp-core
            # geppkgs.hpp-manipulation
            # geppkgs.hpp-manipulation-urdf
            # geppkgs.hpp-pinocchio
            # geppkgs.hpp-statistics
            # geppkgs.hpp-template-corba
            # # geppkgs.hpp-tools
            # geppkgs.hpp-util

            # ROS packages
            (with pkgs.rosPackages.humble; buildEnv {
              paths = [
                # Core packages
                ros-core
                
                
                # Tutorials
                turtlesim

              ];
            })
          ];
        };
      });
  nixConfig = {
    extra-trusted-substituters = [ "https://ros.cachix.org" ];
    extra-trusted-public-keys = [ "ros.cachix.org-1:dSyZxI8geDCJrwgvCOHDoAfOm5sV1wCPjBkKL+38Rvo=" ];
  };
}
