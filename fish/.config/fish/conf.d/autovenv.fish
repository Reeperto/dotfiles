function python_venv --on-variable PWD
    set -l tree (pwd)
    while test "$tree" != /
        for myvenv in "$tree/.venv" "$tree/venv"
            if test -d "$myvenv"
                if test "$PATH[1]" != "$myvenv/bin"
                    if functions -q deactivate
                        deactivate
                    end
                    source "$myvenv/bin/activate.fish"
                end
                return
            end
        end
        set tree (dirname "$tree")
    end
    if functions -q deactivate
        deactivate
    end
end
