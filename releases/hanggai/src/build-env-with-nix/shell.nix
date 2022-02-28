with import <nixpkgs> {};
with pkgsi686Linux;

let
    gccNoCet = gcc11.cc.overrideAttrs (oldAttrs : rec { 
        configureFlags = [ "--disable-cet" ] ++ oldAttrs.configureFlags;
    });
 
    gccNoCetWrap = wrapCCWith rec {
        cc = gccNoCet;
    };   

in (overrideCC stdenv gccNoCetWrap).mkDerivation
{
    name = "gccnocet";
    hardeningDisable = [ "all" ];

    buildInputs = [
        ncurses
        ncurses.dev
        pkg-config
	gnumake
	flex
	bison
	which
	autoconf
	rsync
        less
    ];

    shellHook = ''
	export CFLAGS="-m32 -march=i486 -mtune=i486 -fcf-protection=none -fno-stack-protector -fomit-frame-pointer -mno-mmx -mno-sse -fno-pic -Os"
	export CC="gcc"
	cd ..

	# set strip and ar
	mkdir -p ./gray486/bin/
	pushd ./gray486/bin/ &> /dev/null
	rm -rf ./musl-strip
	rm -rf ./musl-ar

	ln -s "$(which strip)" musl-strip
	ln -s "$(which ar)" musl-ar

	popd &> /dev/null
    '';
}
