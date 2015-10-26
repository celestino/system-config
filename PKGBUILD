# Maintainer: Celestino Diaz <celestino.diaz@gmx.de>
pkgname=tools-config-git
pkgver=v0.1.0
pkgrel=1
pkgdesc="Installer containing base tools configuration"
arch=('any')
url="https://github.com/celestino/tools-config"
license=('MIT')
groups=()
depends=(
    'bash'
    'git'
    'terminator'
    'tig'
    'zsh'
    'zsh-syntax-highlighting'
    'vim'
    'vim-airline'
    'vim-nerdtree'
    'vim-supertab'
    'sed'
    'powerline-fonts-git'
)
makedepends=('git')
provides=("${pkgname}")
conflicts=("${pkgname}")
source=('git+https://github.com/celestino/'"${pkgname%-git}"'.git')
md5sums=('SKIP')

pkgver() {
	cd "$srcdir/${pkgname%-git}"
	printf "%s" "$(git describe --long --tags | sed 's/\([^-]*-\)g/r\1/;s/-/./g')"
}

package() {
    local installDir="${pkgdir}/usr/local"
    local binDir="${pkgdir}/usr/local/bin"
    mkdir -p "$installDir" "$binDir"
    cp -R "${pkgname%-git}/" "$installDir/${pkgname}"
    sed -i -e "s/@SOURCE_DIR@/$(echo "/usr/local/${pkgname}" | sed -e 's/\\/\\\\/g' -e 's/\//\\\//g' -e 's/&/\\\&/g')/g" \
        "${installDir}/${pkgname}/${pkgname%-git}"
    ln -s "/usr/local/${pkgname}/${pkgname%-git}" "${binDir}/${pkgname%-git}"
}
