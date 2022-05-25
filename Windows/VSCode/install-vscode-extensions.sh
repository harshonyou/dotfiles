#!/bin/bash

# Visual Studio Code :: Package list
# code --list-extensions --show-versions
pkglist=(
aaron-bond.better-comments
apvarun.celestial
bmewburn.vscode-intelephense-client
brapifra.phpserver
CoachRichbart.lite-brite
CoenraadS.bracket-pair-colorizer-2
dbaeumer.vscode-eslint
dsznajder.es7-react-js-snippets
Equinusocio.vsc-community-material-theme
Equinusocio.vsc-material-theme
equinusocio.vsc-material-theme-icons
esbenp.prettier-vscode
formulahendry.auto-rename-tag
formulahendry.code-runner
GrapeCity.gc-excelviewer
haskell.haskell
icrawl.discord-vscode
jcbuisson.vue
justusadam.language-haskell
kamikillerto.vscode-colorize
mrmlnc.vscode-scss
ms-python.python
ms-python.vscode-pylance
ms-toolsai.jupyter
ms-toolsai.jupyter-keymap
ms-toolsai.jupyter-renderers
ms-vscode-remote.remote-containers
ms-vscode-remote.remote-ssh
ms-vscode-remote.remote-wsl
ms-vscode-remote.vscode-remote-extensionpack
ms-vscode.cpptools
ms-vsliveshare.vsliveshare
ms-vsliveshare.vsliveshare-audio
ms-vsliveshare.vsliveshare-pack
Nur.just-black
PKief.material-icon-theme
redhat.java
RobbOwen.synthwave-vscode
sibiraj-s.vscode-scss-formatter
SonarSource.sonarlint-vscode
tomoki1207.pdf
VisualStudioExptTeam.vscodeintellicode
vscjava.vscode-java-debug
vscjava.vscode-java-dependency
vscjava.vscode-java-pack
vscjava.vscode-java-test
vscjava.vscode-maven
vscodevim.vim
wayou.vscode-todo-highlight
XephAlpha.syntax
)

for i in ${pkglist[@]}; do
  code --install-extension $i
done
