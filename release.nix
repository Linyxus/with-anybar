let
  pkgs = import <nixpkgs> { };

in
  { with-anybar = pkgs.haskellPackages.callPackage ./with-anybar.nix { };
  }
