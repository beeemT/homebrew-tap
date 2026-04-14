class Substrate < Formula
  desc "AI-powered work item orchestration for multi-repo development"
  homepage "https://github.com/beeemT/substrate"
  license "MIT"
  version "0.0.1-alpha21"

  depends_on "beeemT/tap/git-work"
  # Optional CLIs intentionally not hard dependencies:
  # - gh: only needed for GitHub CLI token fallback and harness-driven GitHub login
  # - glab: only needed for GitLab MR lifecycle automation

  on_macos do
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha21/substrate_0.0.1-alpha21_darwin_arm64.tar.gz"
      sha256 "d5a3b42e249a04fda7c93bad746aa75bf8b2969e60be061dbf0513d014ef595e"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha21/substrate_0.0.1-alpha21_darwin_amd64.tar.gz"
      sha256 "2eb7fdb76d4b5ed9542bbd6b29114a523dc9cbb9be9ce5486f2cf0f27b669c0d"
    end
  end
  on_linux do
    depends_on "bubblewrap"
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha21/substrate_0.0.1-alpha21_linux_arm64.tar.gz"
      sha256 "1813743118f9d83b03d35cae93dcc38a9226dfa89d99578a93ea9a0e174f0667"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha21/substrate_0.0.1-alpha21_linux_amd64.tar.gz"
      sha256 "926030ac4c620f2104bba1b66574eac00ac3c6ca43a37032e891a5d6dc1c0d37"
    end
  end

  def install
    bin.install "substrate"
    pkgshare.install "bridge"
  end

  test do
    assert_match "substrate", shell_output("#{bin}/substrate --help 2>&1", 0).downcase
    assert_path_exists pkgshare/"bridge/omp-bridge"
    assert_match "session_ready", pipe_output("#{pkgshare}/bridge/omp-bridge", '{"type":"abort"}\n', 0)
    assert_path_exists pkgshare/"bridge/claude-agent-bridge"
    assert_match "claude-agent-bridge", shell_output("#{pkgshare}/bridge/claude-agent-bridge --version", 0)
  end
end
