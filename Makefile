.PHONY: update clean bootstrap

update:
	home-manager switch --flake .#aalkornev

bootstrap:
	nix run home-manager/release-25.11 -- switch  --flake .#aalkornev

install-nix:
	sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install)


clean:
	nix-collect-garbage -d

