update:
	cabal2nix . > with-anybar.nix

shell: update
	nix-shell

repl: update
	nix-shell --run "cabal configure; cabal repl exe:with-anybar"

run: update
	nix-shell --run "cabal configure; cabal run"

build: update
	nix-build release.nix

clean:
	rm -rf cabal.*
	rm -rf dist*
	rm -rf result
