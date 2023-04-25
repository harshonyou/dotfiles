-- if vim.fn.has "wsl" == 1 then
--   vim.api.nvim_exec(
--     [[
-- 			let g:clipboard = {
--           \   'name': 'win32yank-wsl',
--           \   'copy': {
--           \      '+': 'win32yank.exe -i --crlf',
--           \      '*': 'win32yank.exe -i --crlf',
--           \    },
--           \   'paste': {
--           \      '+': 'win32yank.exe -o --lf',
--           \      '*': 'win32yank.exe -o --lf',
--           \   },
--           \   'cache_enabled': 0,
--           \ }
-- 		]],
--     true
--   )
-- end

vim.cmd [[
  augroup Yank
  autocmd!
  autocmd TextYankPost * :call system('/mnt/c/windows/system32/clip.exe ',@")
  augroup END
]]

