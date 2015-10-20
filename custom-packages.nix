/*

custom-nixpkgs
==============

Nix packages added or upgraded by myself.

See:

  - http://sandervanderburg.blogspot.com/2014/07/managing-private-nix-packages-outside.html
  - https://nixos.org/wiki/Create_and_debug_nix_packages
  - https://nixos.org/wiki/Debugging_a_Nix_Package
  - https://nixos.org/wiki/Nix_Modifying_Packages
  - http://fluffynukeit.com/adding-nix-expressions-for-new-packages/
  - http://lethalman.blogspot.sg/2014/09/nix-pill-13-callpackage-design-pattern.html

Usage
-----

### Build ###

```
nix-build custom-packages.nix -A <pkg>
```

### Install ###

```
nix-env --file custom-packages.nix --install <pkg>
```

*/

{ system ? builtins.currentSystem }:

let

  pkgs = import <nixpkgs> { inherit system; };

  callPackage = pkgs.lib.callPackageWith (pkgs // self);

  self = {

    git-crypt = callPackage ./pkgs/applications/version-management/git-and-tools/git-crypt { };

  };

in

self
