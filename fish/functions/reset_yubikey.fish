function reset_yubikey --description 'Reset currently active YubiKey'
    gpg-connect-agent "scd serialno" "learn --force" /bye
end
