" Automatically fold imports, exports and language pragmas
silent! normal! m`G
silent! /\_^{-#\s\+LANGUAGE\s\+/normal! mlzf}``m`
silent! /\_^module\s\+\_.\{-})\_.\{-}where\s*\_$/normal! mevgnzf``m`
silent! /\_^import\s\+/normal! mizf}``m`
silent! /\_^main\s\+=/normal! mm``m`
let @/ = ""
