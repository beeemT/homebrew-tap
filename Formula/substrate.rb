class Substrate < Formula
  desc "AI-powered work item orchestration for multi-repo development"
  homepage "https://github.com/beeemT/substrate"
  license "MIT"
  version "0.0.27"

  depends_on "beeemT/tap/git-work"
  # Optional CLIs intentionally not hard dependencies:
  # - gh: only needed for GitHub CLI token fallback and harness-driven GitHub login
  # - glab: only needed for GitLab MR lifecycle automation

  on_macos do
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.27/substrate_0.0.27_darwin_arm64.tar.gz"
      sha256 "9ddf6337b7c759937d514abd13d2a0601df7c5651c09126592f367a2351105a2"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.27/substrate_0.0.27_darwin_amd64.tar.gz"
      sha256 "abea0aaa50d64207bdba39d09563374adbaf7af9788dbfd1b0df5c6c8e1de5b1"
    end
  end
  on_linux do
    depends_on "bubblewrap"
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.27/substrate_0.0.27_linux_arm64.tar.gz"
      sha256 "9c7f17583c683f95099c8b514eb99e687a6863fe7c4b0b7207cd3161880df94e"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.27/substrate_0.0.27_linux_amd64.tar.gz"
      sha256 "a6bad817bb8ac45f5999fca8b2c739be64626ec5c7fe1f2678640e177196f055"
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
