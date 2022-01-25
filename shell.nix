{ pkgs ? import<nixpkgs> {}}:
with pkgs;

# see  https://gist.github.com/sirkha/8c6b8f23008baa1ee83cae193e728c77
# to fix the build error for gem5

let python-with-packages = python38.withPackages (p: with p; [
	six
	setuptools
	virtualenv
]); in
mkShell {
	buildInputs = [  autoconf automake
	mpfr libmpc gmp gawk curl
	# omit build-essential
	bison flex texinfo gperf libtool patchutils
	bc qt4
	# omit qt4-dev-tools
	python-with-packages
	python27Full
	scons
	linuxPackages.perf
	libressl
	zlib
	cmake
	gcc
];
	SHELL_NAME = "DSAGEN";
	shellHook = ''
    PYTHONPATH=${python-with-packages}/${python-with-packages.sitePackages}
    # maybe set more env-vars
  '';

}
