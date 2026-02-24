home:
  home-manager switch --flake .

desktop:
  sudo nixos-rebuild switch --flake .#desktop --impure

darwin:
  sudo darwin-rebuild switch --flake .#intel-mac --impure


update:
  nix flake update

clean:
  nix-collect-garbage -d

