#!/bin/bash

setKeyboardLayout(){
    items=$(find /usr/share/kbd/keymaps/ -type f -printf "%f\n" | sort -V)
    echo $items
    echo "loadkeys ${keymap}"
	loadkeys ${keymap}
}


setKeyboardLayout();