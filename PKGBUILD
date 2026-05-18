# Maintainer: Danish <danish@anomalyco.dev>
# Contributor: Danish <danish@anomalyco.dev>

pkgname=poleplex
pkgver=1.0.0
pkgrel=1
pkgdesc='A minimalist AUR package downloader'
arch=('any')
url='https://github.com/anomalyco/poleplex'
license=('MIT')
depends=('curl' 'git' 'tar')
makedepends=()
optdepends=()
provides=('poleplex')
conflicts=()
replaces=()
source=("${pkgname}-${pkgver}.tar.gz::${url}/archive/v${pkgver}.tar.gz")
sha256sums=('SKIP')
install=poleplex.install

package() {
  cd "${srcdir}/${pkgname}-${pkgver}"

  install -Dm755 poleplex "${pkgdir}/usr/bin/poleplex"

  install -Dm644 LICENSE "${pkgdir}/usr/share/licenses/${pkgname}/LICENSE"

  install -Dm644 man/poleplex.1 "${pkgdir}/usr/share/man/man1/poleplex.1"

  install -Dm644 completions/poleplex.bash "${pkgdir}/usr/share/bash-completion/completions/poleplex"
  install -Dm644 completions/poleplex.zsh "${pkgdir}/usr/share/zsh/site-functions/_poleplex"
  install -Dm644 completions/poleplex.fish "${pkgdir}/usr/share/fish/vendor_completions.d/poleplex.fish"

  install -Dm644 README.md "${pkgdir}/usr/share/doc/${pkgname}/README.md"
}
