.PHONY: update clean bootstrap

SYSTEM := $(shell uname -s)

update:
	home-manager switch --flake .#aalkornev@$(SYSTEM)

bootstrap:
	nix run home-manager/release-25.11 -- switch  --flake .#aalkornev@$(SYSTEM)

install-nix:
	sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install)


clean:
	nix-collect-garbage -d

