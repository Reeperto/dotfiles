vim.api.nvim_create_user_command("ReplaceSmartQuotes", function()
    vim.cmd [[:%s/[“”]/"/g]]
end, {})
