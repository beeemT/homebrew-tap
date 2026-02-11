class GitWork < Formula
  desc "Branch-per-directory workflow wrapping git worktree"
  homepage "https://github.com/beeemT/git-work"
  url "https://github.com/beeemT/git-work/releases/download/v0.1.3/git-work_0.1.3.tar.gz"
  sha256 "af563199c2ab13e6771ab41c82cb219ac5db5ae69c6903e7d5faa373f9c46586"
  license "MIT"

  depends_on "erlang"

  def install
    bin.install "git-work"
  end

  test do
    assert_match "usage: git-work", shell_output("#{bin}/git-work --help 2>&1", 0)
  end
end
