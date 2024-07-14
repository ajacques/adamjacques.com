{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
    nativeBuildInputs = with pkgs.buildPackages; [
        (ruby_3_3.override {
            docSupport = false;
        })
        pkgs.libmysqlclient
        pkgs.libyaml
        pkgs.nodejs
        pkgs.yarn
    ];
}
