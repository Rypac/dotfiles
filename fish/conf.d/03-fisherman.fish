if not status --is-interactive
    exit
end

# Install fisherman and plugins
if not functions -q fisher
    set -l fisher_home "$XDG_CONFIG_HOME/fish/functions/fisher.fish"
    curl -Lo "$fisher_home" --create-dirs git.io/fisher
    source "$fisher_home"
    fisher
end
