function pdf
    set file (fd -H ".*\.pdf" | sk)
    if test -n "$file"
        switch (uname)
            case Linux
                zathura "$file" 2>&1 >/dev/null & disown
            case Darwin
                sioyek "$file" 2>&1 >/dev/null & disown
        end
    end
end
