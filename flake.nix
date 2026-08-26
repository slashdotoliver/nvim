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
            # LazyVim and Neovim
            git
            ripgrep
            fd
            fzf
            unzip
            curl
            wget

            # Tools and UI
            tree-sitter

            fzf
            lazygit
            chafa
            imagemagick

            # Tree-sitter parser compilation
            gcc
            gnumake

            # Runtimes for LSPs
            #nodejs
            #python3

            # # === Mason Tools ===
            lua-language-server         # lua
            stylua
            pyright                     # python
            ruff
            shfmt                       # shell
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
