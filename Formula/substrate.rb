class Substrate < Formula
  desc "AI-powered work item orchestration for multi-repo development"
  homepage "https://github.com/beeemT/substrate"
  license "MIT"
  version "0.0.37"

  depends_on "beeemT/tap/git-work"
  # Optional CLIs intentionally not hard dependencies:
  # - gh: only needed for GitHub CLI token fallback and harness-driven GitHub login
  # - glab: only needed for GitLab MR lifecycle automation

  on_macos do
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.37/substrate_0.0.37_darwin_arm64.tar.gz"
      sha256 "bc1ae6d6f3119c4ea25a737386a6c68735608fc0875b5ef005b627569d6a4217"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.37/substrate_0.0.37_darwin_amd64.tar.gz"
      sha256 "cf61d4ae91de866b49c00fc2372d74f0c78bbdc08991d73209bcd53d9abd23f6"
    end
  end
  on_linux do
    depends_on "bubblewrap"
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.37/substrate_0.0.37_linux_arm64.tar.gz"
      sha256 "343f613768087041047b12ce68321a7505f321d68e669b7f78e173dc3d9805aa"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.37/substrate_0.0.37_linux_amd64.tar.gz"
      sha256 "23a069627db97f0b0a02d81325bcaa31e76b5b9c8c0627a126b47226b01dc990"
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
