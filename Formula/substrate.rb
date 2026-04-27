class Substrate < Formula
  desc "AI-powered work item orchestration for multi-repo development"
  homepage "https://github.com/beeemT/substrate"
  license "MIT"
  version "0.0.35"

  depends_on "beeemT/tap/git-work"
  # Optional CLIs intentionally not hard dependencies:
  # - gh: only needed for GitHub CLI token fallback and harness-driven GitHub login
  # - glab: only needed for GitLab MR lifecycle automation

  on_macos do
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.35/substrate_0.0.35_darwin_arm64.tar.gz"
      sha256 "18d63122a9dbefebee8cd4138eb32b75ea6fda5940d404b91ef751ae3266b6f9"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.35/substrate_0.0.35_darwin_amd64.tar.gz"
      sha256 "6e54f0610baf8da5d129c051c8c26a84789969671cb3fc90bf8dd8fc05eb02af"
    end
  end
  on_linux do
    depends_on "bubblewrap"
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.35/substrate_0.0.35_linux_arm64.tar.gz"
      sha256 "bce5ea3449cf83ec9439d3ca405bec240fcdb0042044d1cc925f5ac2484cc129"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.35/substrate_0.0.35_linux_amd64.tar.gz"
      sha256 "a2df5e122bbe1da5d53ce6db55b48da2f1b342c62acec6f64a179e77f238cd8b"
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
