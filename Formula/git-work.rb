class GitWork < Formula
  desc "Branch-per-directory workflow wrapping git worktree"
  homepage "https://github.com/beeemT/git-work"
  url "https://github.com/beeemT/git-work/releases/download/v0.2.6/git-work_0.2.6.tar.gz"
  sha256 "b09cb6d6dc279ef924688b95fb05eefdd7e6c2f63ede81101a5c619f9aedac71"
  license "MIT"

  depends_on "erlang"

  def install
    bin.install "git-work"
  end

  test do
    assert_match "usage: git-work", shell_output("#{bin}/git-work --help 2>&1", 0)
  end
end
