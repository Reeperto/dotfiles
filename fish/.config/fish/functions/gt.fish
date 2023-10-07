function gt --wraps='fd -t d | sk' --wraps='cd (fd -t d | sk)' --wraps='cd (fd -t d ~ | sk)' --wraps='cd (fd -t d . ~ | sk)' --wraps='cd (fd --type directory . ~ | sk)' --description 'alias gt cd (fd --type directory . ~ | sk)'
  cd (fd --type directory . ~ | sk) $argv
        
end
