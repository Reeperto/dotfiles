function todo --wraps='rg TODO' --description 'alias todo=rg TODO'
  rg TODO $argv
end
