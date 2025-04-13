require("codecompanion").setup({
  strategies = {
    chat = {
      adapter = "gemma3",
    },
    inline = {
      adapter = "qwen",
    },
    cmd = {
      adapter = "qwen",
    },
  },
  adapters = {
    opts = {
      show_defaults = false,
    },
    ollama = function()
      return require("codecompanion.adapters").extend("ollama", {
        schema = {
          model = {
            default = "gemma3:4b",
          },
        },
      })
    end,
    qwen = function()
      return require("codecompanion.adapters").extend("ollama", {
        name = "qwen",
        schema = {
          model = {
            default = "qwen2.5-coder:7b",
          },
        },
      })
    end,
    gemma3 = function()
      return require("codecompanion.adapters").extend("ollama", {
        name = "gemma3",
        schema = {
          model = {
            default = "gemma3:4b",
          },
        },
      })
    end,
  },
  display = {
    action_palette = {
      provider = "mini_pick",
    },
    diff = {
      provider = "mini_diff",
    },
  },
})

vim.keymap.set({ "n", "v" }, "<Leader>A", "<Cmd>CodeCompanionActions<CR>", {
  desc = "Show CodeCompanion actions",
})

vim.keymap.set({ "n", "v" }, "<Leader>C", "<Cmd>CodeCompanionChat Toggle<CR>", {
  desc = "Toggle chat window",
})

vim.keymap.set("v", "ga", "<Cmd>CodeCompanionChat Add<CR>", {
  desc = "Add to chat",
})

-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd("cab cc CodeCompanion")
