PATH="$HOME/scripts:$PATH"
# make sure that node
[[ -s "$(which node)" ]] && PATH="$(npm bin):$PATH"
