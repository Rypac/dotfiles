# gpgconf: utility to configure GnuPG
# https://www.gnupg.org/documentation/manuals/gnupg/gpgconf.html
if status is-interactive; and command -q gpgconf
    set -gx GPG_TTY (tty)
    set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
    gpgconf --launch gpg-agent
end
