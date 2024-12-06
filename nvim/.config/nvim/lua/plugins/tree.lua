return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('nvim-tree').setup({
      on_attach = function(bufnr)
        local api = require('nvim-tree.api')

        -- Default keybindings
        api.config.mappings.default_on_attach(bufnr)

        local function opts(desc)
          return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- Support for `git add` from file tree
        -- https://github.com/nvim-tree/nvim-tree.lua/wiki/Recipes#git-stage-unstage-files-and-directories-from-the-tree
        local git_add = function()
          local node = api.tree.get_node_under_cursor()
          local gs = node.git_status.file

          -- If the current node is a directory get children status
          if gs == nil then
            gs = (node.git_status.dir.direct ~= nil and node.git_status.dir.direct[1])
                 or (node.git_status.dir.indirect ~= nil and node.git_status.dir.indirect[1])
          end

          -- If the file is untracked, unstaged or partially staged, we stage it
          if gs == '??' or gs == 'MM' or gs == 'AM' or gs == ' M' then
            vim.cmd('silent !git add ' .. node.absolute_path)

          -- If the file is staged, we unstage
          elseif gs == 'M ' or gs == 'A ' then
            vim.cmd('silent !git restore --staged ' .. node.absolute_path)
          end

          api.tree.reload()
        end

        vim.keymap.set('n', 'ga', git_add, opts('Git Add'))
      end,
    })
  end,
}

