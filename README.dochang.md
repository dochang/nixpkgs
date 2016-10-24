Bootstrap
---------

```
git remote add NixOS https://github.com/NixOS/nixpkgs.git
git remote add origin https://github.com/dochang/nixpkgs.git
git remote add channels https://github.com/NixOS/nixpkgs-channels.git
git fetch --multiple NixOS origin channels
git show-branch origin/master origin/nixpkgs-unstable channels/nixpkgs-unstable
```

Update
------

```
git show-branch master nixpkgs-unstable origin/master origin/nixpkgs-unstable channels/nixpkgs-unstable
git rebase channels/nixpkgs-unstable nixpkgs-unstable
git rebase --onto=nixpkgs-unstable origin/nixpkgs-unstable master
git push -f origin master nixpkgs-unstable
```
