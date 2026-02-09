.PHONY: update clean bootstrap

update:
	home-manager switch --flake .#aalkornev

bootstrap:
	nix run home-manager/release-25.11 -- switch  --flake .#aalkornev

clean:
	nix-collect-garbage -d

