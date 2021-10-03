function preview --wraps=fzf --description 'Preview using fzf and bat'
    if command -q bat
        command fzf --preview 'bat --style=full --color=always {}'
    else
        command fzf --preview 'cat {}'
    end
end
