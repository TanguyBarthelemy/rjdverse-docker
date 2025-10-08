echo "
.libPaths(file.path(Sys.getenv(\"HOME\"), \"renv\", \"library\"))
" >> "${HOME}/.Rprofile"

curl -LsSf https://github.com/posit-dev/air/releases/latest/download/air-installer.sh | sh
source $HOME/.local/bin/env
