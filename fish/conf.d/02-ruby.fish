if status --is-interactive; and command -sq rbenv
    source (rbenv init -|psub)
end
