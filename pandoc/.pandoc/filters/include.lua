local pattern = [[!include "(.*)"]];

return {
	{
		CodeBlock = function(block)
			local match = block.text:match(pattern)
			if match then
				local file_content = io.open(match, "r"):read("*a")
				block.text = block.text:gsub(pattern, file_content)
				return block
			else
				return block
			end
		end,
	},
}
