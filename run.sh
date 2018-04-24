#!/bin/bash

xhost +local:docker

docker run -d \
  -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
  -v ${PWD}:/project \
  -v ${HOME}/.config/Code:/developer/.config/Code \
  -v ${HOME}/.vscode:/developer/.vscode \
  -v ${HOME}/.ssh:/developer/.ssh \
  -v ${SSH_AUTH_SOCK}:/ssh_auth_sock \
  -v ${HOME}/.gitconfig:/developer/.gitconfig \
  -e DISPLAY=unix${DISPLAY} \
  --name ide \
  --entrypoint "urxvt" \
  nullvoxpopuli/ide

  # docker exec docker-vscode /developer/bin/devrun code
