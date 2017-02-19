function decrypt --description 'Decrypt a GPG encrypted file'
    command gpg2 --decrypt --quiet $argv
end
