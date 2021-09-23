if command -q cocoapods
    set -gx CP_HOME_DIR "$XDG_CACHE_HOME/cocoapods"
    set -gx CP_REPOS_DIR "$CP_HOME_DIR/repos"
end
