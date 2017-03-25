#!/usr/bin/env bash
{
    [[ ! -e build ]] && mkdir build
    cd build

    git clone https://aur.archlinux.org/package-query.git package-query
    cd package-query
    makepkg -si --noconfirm
    cd ..
    rm -rf package-query

    git clone https://aur.archlinux.org/yaourt.git yaourt
    cd yaourt
    makepkg -si --noconfirm
    cd ..
    rm -rf yaourt

    cd ..
} 2>&1 1> /dev/null