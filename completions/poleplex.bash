_poleplex() {
  local cur prev words cword
  _init_completion || return

  local commands="s search i info d download r remove u update h help V version"
  local opts="-h --help -V --version -v --verbose -q --quiet -s --search -i --info -p --path -t --tarball -u --update"

  if [[ $cword -eq 1 ]]; then
    COMPREPLY=($(compgen -W "${commands} ${opts}" -- "${cur}"))
    return 0
  fi

  case "${words[1]}" in
    s|search|i|info)
      ;;
    d|download|r|remove)
      if [[ "${cur}" == -* ]]; then
        COMPREPLY=($(compgen -W "-p --path -t --tarball -v --verbose -q --quiet" -- "${cur}"))
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
