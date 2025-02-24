return {
  'numToStr/Comment.nvim',
  config = function()
    require('Comment').setup();
    -- TODO: Figure out how to make a <C-?> binding for commenting.
  end,
}

