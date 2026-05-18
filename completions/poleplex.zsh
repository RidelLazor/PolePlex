#compdef poleplex

local state line

_arguments -C \
  '(-h --help)'{-h,--help}'[Show help message]' \
  '(-V --version)'{-V,--version}'[Show version]' \
  '(-v --verbose)'{-v,--verbose}'[Verbose output]' \
  '(-q --quiet)'{-q,--quiet}'[Suppress informational output]' \
  '(-s --search)'{-s,--search}'[Search AUR for packages]:search term:' \
  '(-i --info)'{-i,--info}'[Show package info from AUR]:package:' \
  '(-p --path)'{-p,--path}'[Download/remove from specific directory]:directory:_files -/' \
  '(-t --tarball)'{-t,--tarball}'[Use tarball download instead of git clone]' \
  '(-u --update)'{-u,--update}'[Update all AUR packages in directory]:directory:_files -/' \
  '1:command:->cmds' \
  '*::args:->args'

case "$state" in
  cmds)
    _describe 'command' '(
      "s:Search AUR"
      "search:Search AUR"
      "i:Package info"
      "info:Package info"
      "d:Download package"
      "download:Download package"
      "r:Remove package"
      "remove:Remove package"
      "u:Update all"
      "update:Update all"
      "h:Help"
      "help:Help"
      "V:Version"
      "version:Version"
    )'
    ;;
  args)
    case "$words[1]" in
      d|download|r|remove)
        _arguments ':package:' ;;
      u|update)
        _arguments ':directory:_files -/' ;;
    esac
    ;;
esac
