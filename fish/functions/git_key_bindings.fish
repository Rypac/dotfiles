function git_key_bindings
    function git_is_repo -d 'Test if the current directory is a Git repository'
        if not command git rev-parse --git-dir >/dev/null 2>/dev/null
            return 1
        end
    end

    function gco -d 'Checkout a Git branch with FZF filtering'
        if git_is_repo
            git checkout (string trim -- (git branch | fzf))
            and commandline -f repaint
        end
    end

    function gcor -d 'Checkout a remote Git branch with FZF filtering'
        if git_is_repo
            git checkout (string trim -- (git branch --all | fzf))
            and commandline -f repaint
        end
    end

    bind \eg gco
    bind \eG gcor

    if bind -M insert >/dev/null 2>&1
        bind -M insert \eg gco
        bind -M insert \eG gcor
    end
end
