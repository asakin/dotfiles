class Dotfiles < Formula
  desc "Minimal, opinionated zsh environment: Starship prompt, Antidote plugins, fzf, zoxide"
  homepage "https://github.com/asakin/dotfiles"
  url "https://github.com/asakin/dotfiles/archive/refs/tags/v1.0.2.tar.gz"
  sha256 "03fdb34c8ddec92e869fc67c0fe63e48a4deccc6f784eca1f34e826d0a0fb27e"
  license "MIT"

  depends_on "starship"
  depends_on "zoxide"
  depends_on "fzf"

  def install
    bin.install "install.sh" => "dotfiles-install"
    bin.install "setup.sh"   => "dotfiles-setup"
    bin.install "uninstall.sh" => "dotfiles-uninstall"
    prefix.install "home"
  end

  def post_install
    # Install tools via setup script
    system "#{bin}/dotfiles-setup"
  end

  def caveats
    <<~EOS
      Symlink dotfiles into your home directory:
        dotfiles-install

      This will:
        - Clone the repo to ~/.config/dotfiles
        - Symlink .zshrc, .zsh_plugins.txt, and .config/starship.toml
        - Back up any existing files before replacing them

      To undo:
        dotfiles-uninstall

      Then reload your shell:
        source ~/.zshrc
    EOS
  end

  test do
    assert_predicate bin/"dotfiles-install", :exist?
  end
end
