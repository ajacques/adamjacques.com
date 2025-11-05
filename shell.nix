{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
    nativeBuildInputs = with pkgs.buildPackages; [
        pkgs.ruby_3_3
        pkgs.libmysqlclient
        pkgs.libyaml
        pkgs.nodejs
        pkgs.yarn
    ];
}
