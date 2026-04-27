class Substrate < Formula
  desc "AI-powered work item orchestration for multi-repo development"
  homepage "https://github.com/beeemT/substrate"
  license "MIT"
  version "0.0.34"

  depends_on "beeemT/tap/git-work"
  # Optional CLIs intentionally not hard dependencies:
  # - gh: only needed for GitHub CLI token fallback and harness-driven GitHub login
  # - glab: only needed for GitLab MR lifecycle automation

  on_macos do
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.34/substrate_0.0.34_darwin_arm64.tar.gz"
      sha256 "5ea02bd99076c79bfc4c73a4773fd9c52f3560deeb12b7fdb8c54b39e7152414"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.34/substrate_0.0.34_darwin_amd64.tar.gz"
      sha256 "e994fb8cb090a7b6aede46c286387c311b35c5d79a8f5944bf11c34e29e5e6ce"
    end
  end
  on_linux do
    depends_on "bubblewrap"
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.34/substrate_0.0.34_linux_arm64.tar.gz"
      sha256 "86f6241861ed7da3176a53ac74e42b7490129affff9e6ac617d9bca812d61c54"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.34/substrate_0.0.34_linux_amd64.tar.gz"
      sha256 "aca6f5b7a6c7322e7c2d3d2497ebfa0d4af3ccf68d4ec298ffbf6b869c729bd7"
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
