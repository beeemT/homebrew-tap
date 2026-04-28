class Substrate < Formula
  desc "AI-powered work item orchestration for multi-repo development"
  homepage "https://github.com/beeemT/substrate"
  license "MIT"
  version "0.0.38"

  depends_on "beeemT/tap/git-work"
  # Optional CLIs intentionally not hard dependencies:
  # - gh: only needed for GitHub CLI token fallback and harness-driven GitHub login
  # - glab: only needed for GitLab MR lifecycle automation

  on_macos do
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.38/substrate_0.0.38_darwin_arm64.tar.gz"
      sha256 "cdd1f2c66e88b889f43bb9b244b8b673313e6f27f66fb9de90b09ca4edab8fa1"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.38/substrate_0.0.38_darwin_amd64.tar.gz"
      sha256 "4c84e00e4dfb7359f1c19888beb030b983674e69dd19ab03d93819c806f05907"
    end
  end
  on_linux do
    depends_on "bubblewrap"
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.38/substrate_0.0.38_linux_arm64.tar.gz"
      sha256 "e1b2bc943bb4c63877658d43def47c109d303360f7aa17179b85bdb51c5a05f2"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.38/substrate_0.0.38_linux_amd64.tar.gz"
      sha256 "1f080275529cd7e9b71a9a54c25afd42c398cf49459c9243d4a9c9fd1fb101cf"
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
