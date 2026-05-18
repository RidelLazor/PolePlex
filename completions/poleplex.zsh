#compdef poleplex

local state line

_arguments -C \
  '(-h --help)'{-h,--help}'[Show help message]' \
  '(-V --version)'{-V,--version}'[Show version]' \
  '(-v --verbose)'{-v,--verbose}'[Verbose output]' \
  '(-q --quiet)'{-q,--quiet}'[Suppress informational output]' \
  '(-c --chroot)'{-c,--chroot}'[Enable clean chroot builds]' \
  '(-j --jobs)'{-j,--jobs}'[Parallel build jobs]:number:' \
  '(-s --search)'{-s,--search}'[Search AUR]:search term:' \
  '(-i --info)'{-i,--info}'[Show package info]:package:' \
  '(-p --path)'{-p,--path}'[Working directory]:directory:_files -/' \
  '(-t --tarball)'{-t,--tarball}'[Use tarball instead of git clone]' \
  '(-u --update)'{-u,--update}'[Update all packages]:directory:_files -/' \
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
      "install:Download + build + install"
      "b:Build only"
      "build:Build only"
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
      d|download|install|b|build|r|remove)
        _arguments ':package:' ;;
      u|update)
        _arguments ':directory:_files -/' ;;
    esac
    ;;
esac
