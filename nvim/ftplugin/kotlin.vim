" Automatically fold imports
silent! normal! m`G
silent! /\_^import\s\+/normal! mizf}``m`
let @/ = ""
