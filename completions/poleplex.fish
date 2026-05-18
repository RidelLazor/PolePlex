# Commands
complete -c poleplex -f -n "not __fish_seen_subcommand_from s search i info d download install b build r remove u update h help V version" -a s        -d "Search AUR"
complete -c poleplex -f -n "not __fish_seen_subcommand_from s search i info d download install b build r remove u update h help V version" -a search   -d "Search AUR"
complete -c poleplex -f -n "not __fish_seen_subcommand_from s search i info d download install b build r remove u update h help V version" -a i        -d "Package info"
complete -c poleplex -f -n "not __fish_seen_subcommand_from s search i info d download install b build r remove u update h help V version" -a info     -d "Package info"
complete -c poleplex -f -n "not __fish_seen_subcommand_from s search i info d download install b build r remove u update h help V version" -a d        -d "Download package"
complete -c poleplex -f -n "not __fish_seen_subcommand_from s search i info d download install b build r remove u update h help V version" -a download -d "Download package"
complete -c poleplex -f -n "not __fish_seen_subcommand_from s search i info d download install b build r remove u update h help V version" -a install  -d "Download + build + install"
complete -c poleplex -f -n "not __fish_seen_subcommand_from s search i info d download install b build r remove u update h help V version" -a b        -d "Build only"
complete -c poleplex -f -n "not __fish_seen_subcommand_from s search i info d download install b build r remove u update h help V version" -a build    -d "Build only"
complete -c poleplex -f -n "not __fish_seen_subcommand_from s search i info d download install b build r remove u update h help V version" -a r        -d "Remove package"
complete -c poleplex -f -n "not __fish_seen_subcommand_from s search i info d download install b build r remove u update h help V version" -a remove   -d "Remove package"
complete -c poleplex -f -n "not __fish_seen_subcommand_from s search i info d download install b build r remove u update h help V version" -a u        -d "Update all"
complete -c poleplex -f -n "not __fish_seen_subcommand_from s search i info d download install b build r remove u update h help V version" -a update   -d "Update all"
complete -c poleplex -f -n "not __fish_seen_subcommand_from s search i info d download install b build r remove u update h help V version" -a h        -d "Show help"
complete -c poleplex -f -n "not __fish_seen_subcommand_from s search i info d download install b build r remove u update h help V version" -a help     -d "Show help"
complete -c poleplex -f -n "not __fish_seen_subcommand_from s search i info d download install b build r remove u update h help V version" -a V        -d "Show version"
complete -c poleplex -f -n "not __fish_seen_subcommand_from s search i info d download install b build r remove u update h help V version" -a version  -d "Show version"

# Options
complete -c poleplex -s h -l help     -d "Show help message"
complete -c poleplex -s V -l version  -d "Show version"
complete -c poleplex -s v -l verbose  -d "Verbose output"
complete -c poleplex -s q -l quiet    -d "Suppress informational output"
complete -c poleplex -s c -l chroot   -d "Enable clean chroot builds"
complete -c poleplex -s j -l jobs     -d "Parallel build jobs" -x
complete -c poleplex -s s -l search   -d "Search AUR for packages" -x
complete -c poleplex -s i -l info    -d "Show package info from AUR" -x
complete -c poleplex -s p -l path    -d "Working directory" -x -a "(__fish_complete_directories)"
complete -c poleplex -s t -l tarball -d "Use tarball instead of git clone"
complete -c poleplex -s u -l update  -d "Update all packages" -x -a "(__fish_complete_directories)"
