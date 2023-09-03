return {
	{
		CodeBlock = function(block)
			for file in block.text:gmatch([[!include "([^"]*)"]]) do
				local file_content = io.open(file, "r"):read("*a")
				block.text = block.text:gsub(string.format([[!include "%s"]], file), file_content)
			end
			return block
		end,
	},
}
