-- LSP setup (новый стиль для Neovim 0.11)
local lspconfig = require('lspconfig')

-- Pyright
lspconfig.pyright.setup {
  settings = {
    pyright = { disableOrganizeImports = true },
    python = { analysis = { ignore = { '*' } } },
  },
}

-- Typescript (новое имя — ts_ls)
lspconfig.ts_ls.setup {}

-- Rust
lspconfig.rust_analyzer.setup {}

-- Ruff (новое имя)
lspconfig.ruff.setup {
  init_options = {
    settings = {
      args = {
        "--select=E,F,UP,N,I,ASYNC,S,PTH",
        "--line-length=79",
        "--respect-gitignore",
        "--target-version=py311",
      },
    },
  },
}

-- Clang
lspconfig.clangd.setup {}

-- Java
lspconfig.jdtls.setup {
  settings = {
    java = {
      configuration = {
        runtimes = {
          {
            name = "JavaSE-17",
            path = "/usr/lib/jvm/java-17-openjdk",
            default = true,
          },
        },
      },
    },
  },
}

-- Диагностики
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

-- Автоматическая настройка после подключения LSP
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
    vim.keymap.set('n', 'Ld', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'Lk', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<space>r', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

