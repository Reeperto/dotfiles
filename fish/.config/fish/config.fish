if status is-interactive
    # Commands to run in interactive sessions can go here
		# ~/dev/projects/shell/pokemon-colorscripts/pokemon-colorscripts.py -r --no-title
end

rtx activate | source
# starship init fish | source
eval (luarocks path)
