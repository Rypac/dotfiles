# zoxide: smarter cd command
# https://github.com/ajeetdsouza/zoxide
if status is-interactive; and command -q zoxide
    zoxide init fish | source
end
