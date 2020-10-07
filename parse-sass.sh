#! /bin/bash

if [ ! "$(which node-sass 2> /dev/null)" ]; then
    echo node-sass needs to be installed to generate the css.
    exit 1
fi

_COLOR_VARIANTS=('' '-light' '-dark')
if [ -n "${COLOR_VARIANTS:-}" ]; then
    IFS=', ' read -r -a _COLOR_VARIANTS <<< "${COLOR_VARIANTS:-}"
fi

_ECOLOR_VARIANTS=('' '-dark')
if [ -n "${ECOLOR_VARIANTS:-}" ]; then
    IFS=', ' read -r -a _ECOLOR_VARIANTS <<< "${ECOLOR_VARIANTS:-}"
fi

_THEME_VARIANTS=('-sea' '-aliz' '-azul')
if [ -n "${THEME_VARIANTS:-}" ]; then
    IFS=', ' read -r -a _THEME_VARIANTS <<< "${THEME_VARIANTS:-}"
fi

for color in "${_COLOR_VARIANTS[@]}"; do
    for theme in "${_THEME_VARIANTS[@]}"; do
        node-sass --output-style compressed --sourcemap=none "src/gtk-3.0/gtk${color}${theme}.scss" "src/gtk-3.0/gtk${color}${theme}.css" &
        echo "==> Generating the gtk${color}${theme}.css..."
    done
done

for color in "${_ECOLOR_VARIANTS[@]}"; do
    for theme in "${_THEME_VARIANTS[@]}"; do
        node-sass --output-style compressed --sourcemap=none "src/gnome-shell/gnome-shell${color}${theme}.scss" "src/gnome-shell/gnome-shell${color}${theme}.css" &
        echo "==> Generating the gnome-shell${color}${theme}.css..."
    done
done

for color in "${_ECOLOR_VARIANTS[@]}"; do
    for theme in "${_THEME_VARIANTS[@]}"; do
        node-sass --output-style compressed --sourcemap=none "src/cinnamon/cinnamon${color}${theme}.scss" "src/cinnamon/cinnamon${color}${theme}.css" &
        echo "==> Generating the cinnamon${color}${theme}.css..."
    done
done

node-sass --style compressed --sourcemap=none src/gtk-3.0/gtk-dark-arch.scss src/gtk-3.0/gtk-dark-arch.css &
echo "==> Generating the gtk-dark-arch.css..."

wait
