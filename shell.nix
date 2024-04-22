{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
    nativeBuildInputs = with pkgs.buildPackages; [ ruby_3_2 pkgs.libmysqlclient pkgs.libyaml ];
}
