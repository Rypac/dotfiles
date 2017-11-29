function decrypt --description 'Decrypt a GPG encrypted file'
    command gpg --decrypt --quiet $argv
end
