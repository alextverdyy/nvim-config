-- Better buffer deletion that preserves window layout
return {
  'famiu/bufdelete.nvim',
  cmd = { 'Bdelete', 'Bwipeout' },
  keys = {
    { '<leader>bd', '<cmd>Bdelete<cr>', desc = 'Delete buffer' },
    { '<leader>bD', '<cmd>Bwipeout<cr>', desc = 'Wipeout buffer' },
  },
}
