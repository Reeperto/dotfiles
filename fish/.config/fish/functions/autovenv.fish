function autovenv --on-variable PWD
    if set -q __autovenv_base_dir
        if string match -q "$__autovenv_base_dir*" "$PWD"
            return
        end

        set -e __autovenv_base_dir
        deactivate

        return
    end

    set venv_dir (fd -1 -d 1 -t directory -H -I "venv")
    
    if test -n "$venv_dir"
        source "$venv_dir/bin/activate.fish"
        set -g __autovenv_base_dir "$PWD"
    end
end
