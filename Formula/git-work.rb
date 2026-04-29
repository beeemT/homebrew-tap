class GitWork < Formula
  desc "Branch-per-directory workflow wrapping git worktree"
  homepage "https://github.com/beeemT/git-work"
  url "https://github.com/beeemT/git-work/releases/download/v0.2.9/git-work_0.2.9.tar.gz"
  sha256 "8056258ffc0282f4ae6c7d5693d1d99a00f3952c83adca9e2d3df771e47a3a20"
  license "MIT"

  depends_on "erlang"

  def install
    bin.install "git-work"
  end

  test do
    assert_match "usage: git-work", shell_output("#{bin}/git-work --help 2>&1", 0)
  end
end
