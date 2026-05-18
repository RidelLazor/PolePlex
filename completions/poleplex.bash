_poleplex() {
  local cur prev words cword
  _init_completion || return

  local commands="s search i info d download install b build r remove u update h help V version"
  local opts="-h --help -V --version -v --verbose -q --quiet -s --search -i --info -p --path -t --tarball -c --chroot -j --jobs -u --update"

  if [[ $cword -eq 1 ]]; then
    COMPREPLY=($(compgen -W "${commands} ${opts}" -- "${cur}"))
    return 0
  fi

  case "${words[1]}" in
    s|search|i|info) ;;
    d|download|install|b|build|r|remove)
      if [[ "${cur}" == -* ]]; then
        COMPREPLY=($(compgen -W "-p --path -t --tarball -c --chroot -j --jobs -v --verbose -q --quiet" -- "${cur}"))
      fi
      ;;
    u|update)
      COMPREPLY=($(compgen -d -- "${cur}"))
      ;;
    *)
      if [[ "${cur}" == -* ]]; then
        COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      fi
      ;;
  esac
}

complete -F _poleplex poleplex
