#!/usr/bin/env fish

echo "Restowing all packages..."

stow -D stow
stow stow

for dir in */
	echo "Restowing $dir"
	stow -R $dir
end
