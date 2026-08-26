{
  description = "Nix flake for LazyVim";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      packages = forAllSystems (
        system:
        let
          pkgs = import nixpkgs { inherit system; };

          dependencies = with pkgs; [
            git
            ripgrep
            fd
            gcc
            gnumake
            fzf
            lazygit
            tree-sitter
            chafa
            imagemagick
            unzip
            curl
            wget
            nodejs
            python3
            cargo
          ];
        in
        {
          default = pkgs.symlinkJoin {
            name = "nix-neovim";
            paths = [ pkgs.neovim ];
            nativeBuildInputs = [ pkgs.makeWrapper ];
            postBuild = ''
              wrapProgram $out/bin/nvim \
                --prefix PATH : ${pkgs.lib.makeBinPath dependencies}
            '';
          };
        }
      );
    };
}
