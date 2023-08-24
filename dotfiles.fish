#!/usr/bin/env fish

echo "Restowing all packages..."

stow -D stow
stow stow

for dir in */
	echo "Unstowing $dir"
	stow -D $dir
	echo "Restowing $dir"
	stow $dir
end
