{ pkgs, config, ... }:

# TODO
# - scroll beyond last line
# + tabs
# + line transition in normal mode ->
# + option navigation
# + formatting on save (exit insert)
# + hover (language server)
{
  programs.neovim = {
    enable = true;

    extraPackages = with pkgs; [ rust-analyzer nerd-font-patcher ];

    plugins = with pkgs.vimPlugins; [
      vim-polyglot
      vim-startify # Start page
      nerdtree # File tree
      nerdcommenter # Easy commenting
      auto-pairs # Matching () [] {}
      feline-nvim # Bottom status bar
      indent-blankline-nvim # Indent guides
      gitsigns-nvim # Git

      # Style
      nightfox-nvim
      nvim-web-devicons
      vim-devicons
      bufferline-nvim
      scrollbar-nvim

      # LSP
      nvim-lspconfig # Collection of common configurations for the Nvim LSP client
      nvim-cmp # Completion framework
      cmp-nvim-lsp # LSP completion source for nvim-cmp

      # Snippets
      ultisnips
      vim-snippets
      vim-vsnip # Snippet engine
      cmp-vsnip # Snippet completion source for nvim-cmp

      # Other usefull completion sources
      cmp-path
      cmp-buffer

      # Fuzzy finder
      popup-nvim
      plenary-nvim
      telescope-nvim

      # Nix
      vim-nix
      # Rust
      vim-toml
      rust-vim
      rust-tools-nvim # Inlay hints and more
      crates-nvim
    ];

    extraConfig = ''
      for f in split(glob('${./config}/*'), '\n')
        exe 'source' f
      endfor
    '';
  };
}
