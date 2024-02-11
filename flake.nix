{
  description = "Latex letter and contract";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self , nixpkgs ,... }: let
    system = "x86_64-linux";
  in {
    devShells."${system}".default = let
      pkgs = import nixpkgs {
        inherit system;
      };
    in pkgs.mkShell {
      packages = with pkgs; [
        # https://nixos.wiki/wiki/TexLive
        texlive.combined.scheme-medium
        pandoc
        inotify-tools # for watching file changes 
      ];
    };
  };
}