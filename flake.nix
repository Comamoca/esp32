{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
    generated = import ./generated.nix;
    sources = generated { inherit pkgs; };

    esp32 = sources.esp32;
  in {
    packages.x86_64-linux.esp32 = pkgs.stdenv.mkDerivation {
      name = "esp32";
      src = esp32;
      unpackPhase = ''
        mkdir -p source
        tar -C source -xvf $src
      '';
      sourceRoot = "source";
      nativeBuildInputs = [
        pkgs.autoPatchelfHook
        pkgs.jq
      ];
      buildInputs = [
        pkgs.xz
        pkgs.zlib
        pkgs.libxml2
        pkgs.python3
        pkgs.libudev-zero
        pkgs.stdenv.cc.cc
      ];
      buildPhase = ''
        jq -r '.[0].Layers | @tsv' < manifest.json > layers
      '';
      installPhase = ''
        mkdir -p $out
        for i in $(< layers); do
          tar -C $out -xvf "$i" home/esp/.cargo home/esp/.rustup || true
        done
        mv -t $out $out/home/esp/{.cargo,.rustup}
        rmdir $out/home/esp
        rmdir $out/home
        export PATH=$out/.rustup/toolchains/esp/bin:$PATH
        export PATH=$out/.rustup/toolchains/esp/xtensa-esp-elf-esp-13.2.0_20230928/stensa-esp-elf/bin:$PATH
        export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

        # [ -d $out/.cargo ] && [ -d $out/.rustup ]
      '';
    };
  };
}
