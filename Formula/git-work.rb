class GitWork < Formula
  desc "Branch-per-directory workflow wrapping git worktree"
  homepage "https://github.com/beeemT/git-work"
  url "https://github.com/beeemT/git-work/releases/download/v0.1.4/git-work_0.1.4.tar.gz"
  sha256 "c79add9498380d99e2c368c704b2d93a1b9a2ce5fa9b9f76158a9d4db45ff545"
  license "MIT"

  depends_on "erlang"

  def install
    bin.install "git-work"
  end

  test do
    assert_match "usage: git-work", shell_output("#{bin}/git-work --help 2>&1", 0)
  end
end
