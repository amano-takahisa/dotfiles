
-- TODO: re-write with autocmd set colorcolumn only in python file.

local options = {
    colorcolumn = '79'
}
print('setting colorcolumn')
for k, v in pairs(options) do
    vim.wo[k] = v
end
