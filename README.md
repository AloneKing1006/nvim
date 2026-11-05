## No Bloat Neovim

minimal neovim, no external plugin manager, native tree-sitter

## Keybinds

Mode  | Key  | Action
--- | --- | ---
`n`  | `<leader>cd`  | Open Ex mode (`:Ex`)
`n`  | `<C-d>`  | Scroll half-page down and keep the cursor centered
`n`  | `<C-u>`  | Scroll half-page up and keep the cursor centered
`n`  | `n`  | Move to next search result and keep it centered
`n`  | `N`  | Move to previous search result and keep it centered
`n`  | `<C-k>`  | Jump to next quickfix entry and keep it centered
`n`  | `<C-j>`  | Jump to previous quickfix entry and keep it centered
`v`  | `J`  | Move selected block down
`v`  | `K`  | Move selected block up
`x`  | `<leader>p`  | Paste without overwriting clipboard
`n`  | `<leader>u`  | Open/Close Undotree
`n`  | `<leader>ff`  | Find files
`n`  | `<leader>fg`  | Find git-tracked files
`n`  | `<leader>fo`  | Open recent files
`n`  | `<leader>fq`  | Open quickfix list
`n`  | `<leader>fh`  | Open help tags
`n`  | `<leader>fb`  | Open buffer list
`n`  | `<leader>fs`  | Grep current string
`n`  | `<leader>fc`  | Grep instances of the current file name without the extension
`n`  | `<leader>fm`  | Find manpages

## LSP

Mode  | Key  | Action
--- | --- | ---
`n`  | `K`  | Hover info
`n`  | `gd`  | Definition
`n`  | `gD`  | Declaration
`n`  | `gi`  | Go to implementation
`n`  | `go`  | Go to type Definition
`n`  | `gr`  | Show reference
`n`  | `gs`  | Show signature help
`n`  | `gl`  | Diagnostics in floating window
`n`  | `<F2>`  | Rename symbole
`n`  | `<F3>`  | Format code
`n`  | `<F4>`  | Show code actions

## LSP requirements on Arch

```bash
sudo pacman -S lua-language-server clang rust-analyzer gopls typescript-language-server
```

also can use npm for java and more
