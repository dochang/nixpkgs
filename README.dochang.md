Bootstrap
---------

```
git remote add origin https://github.com/NixOS/nixpkgs.git
git remote add dochang https://github.com/dochang/nixpkgs.git
git remote add channels https://github.com/NixOS/nixpkgs-channels.git
git fetch --multiple origin dochang channels
git show-branch dochang/master dochang/nixpkgs-unstable channels/nixpkgs-unstable
```

Update
------

```
git show-branch master nixpkgs-unstable dochang/master dochang/nixpkgs-unstable channels/nixpkgs-unstable
git rebase channels/nixpkgs-unstable nixpkgs-unstable
git rebase --onto=nixpkgs-unstable dochang/nixpkgs-unstable master
git push -f dochang master nixpkgs-unstable
```
