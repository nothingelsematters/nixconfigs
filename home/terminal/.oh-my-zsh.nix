{ ... }:

{
  programs.zsh.oh-my-zsh = {
    enable = true;
    theme = "half-life";
    plugins = [
      "git"
      "sudo"
      "python"
      "pip"
      "git-extras"
      "catimg"
      "colored-man-pages"
      "stack"
    ];
  };
}
