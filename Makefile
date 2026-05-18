PREFIX  ?= /usr/local
BINDIR  ?= ${PREFIX}/bin
MANDIR  ?= ${PREFIX}/share/man/man1
DOCDIR  ?= ${PREFIX}/share/doc/poleplex
LICDIR  ?= ${PREFIX}/share/licenses/poleplex
BASHCOMP ?= ${PREFIX}/share/bash-completion/completions
ZSHCOMP  ?= ${PREFIX}/share/zsh/site-functions
FISHCOMP ?= ${PREFIX}/share/fish/vendor_completions.d

.PHONY: install uninstall man completions

install: poleplex completions man
	install -Dm755 poleplex ${DESTDIR}${BINDIR}/poleplex
	install -Dm644 LICENSE ${DESTDIR}${LICDIR}/LICENSE
	install -Dm644 README.md ${DESTDIR}${DOCDIR}/README.md
	install -Dm644 man/poleplex.1 ${DESTDIR}${MANDIR}/poleplex.1
	install -Dm644 completions/poleplex.bash ${DESTDIR}${BASHCOMP}/poleplex
	install -Dm644 completions/poleplex.zsh ${DESTDIR}${ZSHCOMP}/_poleplex
	install -Dm644 completions/poleplex.fish ${DESTDIR}${FISHCOMP}/poleplex.fish
	@echo "PolePlex installed to ${DESTDIR}${BINDIR}/poleplex"

uninstall:
	rm -f ${DESTDIR}${BINDIR}/poleplex
	rm -f ${DESTDIR}${LICDIR}/LICENSE
	rm -f ${DESTDIR}${DOCDIR}/README.md
	rm -f ${DESTDIR}${MANDIR}/poleplex.1
	rm -f ${DESTDIR}${BASHCOMP}/poleplex
	rm -f ${DESTDIR}${ZSHCOMP}/_poleplex
	rm -f ${DESTDIR}${FISHCOMP}/poleplex.fish
	@echo "PolePlex uninstalled"

completions:
	@echo "  Shell completions ready"

man:
	@echo "  Man page ready"
