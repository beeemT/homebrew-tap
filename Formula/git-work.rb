class GitWork < Formula
  desc "Branch-per-directory workflow wrapping git worktree"
  homepage "https://github.com/beeemT/git-work"
  url "https://github.com/beeemT/git-work/releases/download/v0.2.1/git-work_0.2.1.tar.gz"
  sha256 "5e7c982786fa272f748ac687e5e37681134d4b0b6993ae01fb964206e21db20d"
  license "MIT"

  depends_on "erlang"

  def install
    bin.install "git-work"
  end

  test do
    assert_match "usage: git-work", shell_output("#{bin}/git-work --help 2>&1", 0)
  end
end
