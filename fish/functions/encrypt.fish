function encrypt --description 'Encrypt a file to myself using GPG'
    command gpg --encrypt --recipient me@rdavis.xyz --armour --output - $argv
end
