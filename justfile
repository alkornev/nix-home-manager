home:
  home-manager switch --flake .

desktop:
  sudo nixos-rebuild switch --flake .#desktop --impure

update:
  nix flake update

clean:
  nix-collect-garbage -d

