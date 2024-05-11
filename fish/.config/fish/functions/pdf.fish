function pdf
    set file (fd -H ".*\.pdf" | sk)
    if test -n "$file"
        zathura "$file" 2>&1 >/dev/null & disown
    end
end
