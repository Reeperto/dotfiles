function notes
	set file (fd -H "notes\.tex" ~/school/ | sk)

	if test -n "$file"
		cd (path dirname $file)
		nvim $file
	end
end
