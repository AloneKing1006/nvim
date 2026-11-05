-- Global LSP configuration
vim.lsp.config('*', {
    root_markers = { '.git' },
})

-- Diagnostics
vim.diagnostic.config({
    virtual_text = true,
    severity_sort = true,
    float = {
        style = 'minimal',
        border = 'rounded',
        source = 'if_many',
        header = '',
        prefix = '',
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '✘',
            [vim.diagnostic.severity.WARN] = '▲',
            [vim.diagnostic.severity.HINT] = '⚑',
            [vim.diagnostic.severity.INFO] = '»',
        },
    },
})

-- Floating preview configuration
local orig = vim.lsp.util.open_floating_preview

---@diagnostic disable-next-line: duplicate-set-field
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or 'rounded'
    opts.max_width = opts.max_width or 80
    opts.max_height = opts.max_height or 24
    opts.wrap = opts.wrap ~= false
    return orig(contents, syntax, opts, ...)
end

-- LSP attach
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('my.lsp', {}),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        local buf = args.buf

        local map = function(mode, lhs, rhs)
            vim.keymap.set(mode, lhs, rhs, { buffer = buf })
        end

        -- Keymaps
        map('n', 'K', vim.lsp.buf.hover)
        map('n', 'gd', vim.lsp.buf.definition)
        map('n', 'gD', vim.lsp.buf.declaration)
        map('n', 'gi', vim.lsp.buf.implementation)
        map('n', 'go', vim.lsp.buf.type_definition)
        map('n', 'gr', vim.lsp.buf.references)
        map('n', 'gs', vim.lsp.buf.signature_help)
        map('n', 'gl', vim.diagnostic.open_float)
        map('n', '<F2>', vim.lsp.buf.rename)
        map({ 'n', 'x' }, '<F3>', function()
            vim.lsp.buf.format({ async = true })
        end)
        map('n', '<F4>', vim.lsp.buf.code_action)

        -- Document highlight
        if client:supports_method('textDocument/documentHighlight') then
            local highlight_augroup =
                vim.api.nvim_create_augroup('my.lsp.highlight', { clear = false })

            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                buffer = buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                buffer = buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
            })
        end

        -- Format on save
        local excluded_filetypes = {
            php = true,
            c = true,
            cpp = true,
        }

        if not client:supports_method('textDocument/willSaveWaitUntil')
            and client:supports_method('textDocument/formatting')
            and not excluded_filetypes[vim.bo[buf].filetype]
        then
            vim.api.nvim_create_autocmd('BufWritePre', {
                group = vim.api.nvim_create_augroup('my.lsp.format', { clear = false }),
                buffer = buf,
                callback = function()
                    vim.lsp.buf.format({
                        bufnr = buf,
                        id = client.id,
                        timeout_ms = 1000,
                    })
                end,
            })
        end
    end,
})

-- Completion capabilities
local caps = require('cmp_nvim_lsp').default_capabilities()

-- Lua
vim.lsp.config['luals'] = {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
    capabilities = caps,
    settings = {
        Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = { 'vim' } },
            workspace = {
                checkThirdParty = false,
                library = vim.api.nvim_get_runtime_file('', true),
            },
            telemetry = { enable = false },
        },
    },
}

-- C / C++
vim.lsp.config['clangd'] = {
    cmd = { 'clangd' },
    filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
    root_markers = {
        'compile_commands.json',
        '.clangd',
        'configure.ac',
        'Makefile',
        '.git',
    },
    capabilities = caps,
}

-- Rust
vim.lsp.config['rust_analyzer'] = {
    cmd = { 'rust-analyzer' },
    filetypes = { 'rust' },
    root_markers = { 'Cargo.toml', 'rust-project.json', '.git' },
    capabilities = caps,
    settings = {
        ['rust-analyzer'] = {
            cargo = { allFeatures = true },
            formatting = {
                command = { 'rustfmt' },
            },
        },
    },
}

-- Go
vim.lsp.config['gopls'] = {
    cmd = { 'gopls' },
    filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
    root_markers = { 'go.mod', 'go.work', '.git' },
    capabilities = caps,
    settings = {
        gopls = {
            analyses = {
                unusedparams = false,
                ST1003 = false,
                ST1000 = false,
            },
            staticcheck = true,
        },
    },
}

-- JavaScript / TypeScript
vim.lsp.config['ts_ls'] = {
    cmd = { 'typescript-language-server', '--stdio' },
    filetypes = {
        'javascript',
        'javascriptreact',
        'javascript.jsx',
        'typescript',
        'typescriptreact',
        'typescript.tsx',
    },
    root_markers = {
        'package.json',
        'tsconfig.json',
        'jsconfig.json',
        '.git',
    },
    capabilities = caps,
    settings = {
        completions = {
            completeFunctionCalls = true,
        },
    },
}

-- Enable selected language servers
vim.lsp.enable({
    'luals',
    'clangd',
    'rust_analyzer',
    'gopls',
    'ts_ls',
})
