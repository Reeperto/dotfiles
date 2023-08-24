set sep '{::}'
set sqlite ~/Library/Application\ Support/Firefox/Profiles/fcqsefm5.default-release/weave/bookmarks.sqlite

function bbookmarks
	sqlite3 -separator $sep $sqlite \
	  '
	  SELECT i.title, REPLACE(GROUP_CONCAT(t.tag), ",", ", "), u.url FROM items i
	  JOIN urls u ON i.urlId = u.id
	  LEFT OUTER JOIN tags t ON i.id = t.itemId
	  GROUP BY t.itemId
	  ' | 
	awk -F $sep '{printf "%-'$cols's  \x1b[36m%-'$cols's  \x1b[m%-'$cols's\n", $1, $2, $3}' |
	sed -E 's/\x1b\[[0-9;]+m  //g' |
	sk --ansi --multi |
	rg -oP 'https?://.*$'
end
