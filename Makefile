.PHONY: update clean

update:
	home-manager switch --flake .#aalkornev

clean:
	nix-collect-garbage -d

