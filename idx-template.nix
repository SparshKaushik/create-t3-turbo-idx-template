{pkgs}: {
  packages = [
    pkgs.nodejs_20
    pkgs.bun
  ];
  bootstrap = ''
    mkdir -p "$out"
    chmod -R +w "$out"
    bunx create-turbo@latest -e https://github.com/t3-oss/create-t3-turbo "$out" -m bun --skip-install
    mkdir -p "$out/.idx"
    cp -rf ${./dev.nix} "$out/.idx/dev.nix"
  '';
}
