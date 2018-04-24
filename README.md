# Development Environment (.Net, Node, Ruby)

When using docker, ides and the running containers can fight for control of dependency management -- which is mostly a problem in mono-repo setups where docker-compose ignores `.dockerignore` during runtime.  

In order to utilize the same dependency safety as docker, the ide needs to run in the same environment as your code. This image provides that via X11.


### Tools

- git
- make

#### Editors
- VS Code
- Atom
- Vim

#### SDKs and Version Managers
- Mono
- .Net Cli & SDK

For Ruby and Node, keeping the image down, the version managers for each are installed, but no ruby or node version comes installed.
- chruby
- nvm



### Running

```bash
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
```

Because `xrdb -merge /developer/.Xresources` needs to be ran before a gui-launching command, there is a helper script, `devrun` that runs this before `exec`ing the passed command.

For Example:

```bash
docker exec ide devrun atom
```
will launch Atom


## Thanks @cmiles74

Thanks to https://github.com/cmiles74/docker-vscode for doing the hard work for me (figuring out how to connect docker-programs to the host X11 session)

A lot of the setup in this image is taken from cmiles74/docker-vscode
