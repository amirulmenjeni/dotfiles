vim.pack.add {
  'https://github.com/3rd/image.nvim',
}

require('image').setup {
  backend = 'kitty',
  processor = 'magick_cli',
  integrations = {
    markdown = {
      enabled = true,
      download_remote_images = true,
      only_render_image_at_cursor = false,
      filetypes = { 'markdown', 'vimwiki' },
    },
  },
}
