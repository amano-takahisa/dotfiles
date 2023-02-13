if vim.fn.has("unix") == 1 then
	vim.env.LANG = "en_US.UTF-8"
else
	vim.env.LANG = "en"
end
vim.cmd([[ "language " .. os.getenv("LANG") ]])
vim.o.langmenu = os.getenv("LANG")

vim.o.encoding = "utf-8"


