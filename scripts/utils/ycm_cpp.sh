#!/bin/sh

# Copy the .ycm_cpp_conf.py to current directory 
# for YouCompleteMe C-lang support.

cp_conf() {
    cp ~/git/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py .
}

if [[ -e "$PWD/.ycm_extra_conf.py" ]]; then
    read -r -p\
        ".ycm_extra_conf.py already exist in this directory. Overwrite? [y/N]"\
        response
    case "$response" in
        [yY][eE][sS]|[yY])
            cp_conf
        ;;

    *)  
        echo "Aborted."
        ;;
    esac
else
    cp_conf
fi

