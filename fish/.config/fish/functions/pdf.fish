function pdf
    set file (fd -H ".*\.pdf" | sk)
    zathura $file > /dev/null & disown
end
