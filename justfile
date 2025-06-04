set quiet

[private]
default:
  just --list

# Build the flake and run it
run:
  nix run .#

# Format flake
format:
  nix fmt .
