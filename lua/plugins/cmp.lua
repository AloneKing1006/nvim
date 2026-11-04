local cmp = require("cmp")

cmp.setup({
  -- Automatically highlight the first item in the menu
  preselect = cmp.PreselectMode.Item,

  -- How the completion menu behaves
  completion = {
    completeopt = "menu,menuone,noinsert",          -- always show menu, don't auto-insert
    autocomplete = { cmp.TriggerEvent.TextChanged }, -- trigger while typing
  },

  -- Style of the floating documentation window
window = {
    documentation = cmp.config.window.bordered(),
  },

  -- Where suggestions come from
  sources = {
    { name = "path" },                              -- file paths
    { name = "buffer", keyword_length = 3 },        -- words from open buffers (after 3 chars)
  },

  -- Key mappings
  mapping = cmp.mapping.preset.insert({
    ["<CR>"] = cmp.mapping.confirm({ select = false }), -- accept only if explicitly selected
    ["<C-Space>"] = cmp.mapping.complete(),             -- manually open completion
    ["<C-e>"] = cmp.mapping.abort(),                    -- close the menu
    ["<C-n>"] = cmp.mapping.select_next_item(),         -- next item
    ["<C-p>"] = cmp.mapping.select_prev_item(),         -- previous item
  }),
})
