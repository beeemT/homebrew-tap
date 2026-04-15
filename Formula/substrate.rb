class Substrate < Formula
  desc "AI-powered work item orchestration for multi-repo development"
  homepage "https://github.com/beeemT/substrate"
  license "MIT"
  version "0.0.24"

  depends_on "beeemT/tap/git-work"
  # Optional CLIs intentionally not hard dependencies:
  # - gh: only needed for GitHub CLI token fallback and harness-driven GitHub login
  # - glab: only needed for GitLab MR lifecycle automation

  on_macos do
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.24/substrate_0.0.24_darwin_arm64.tar.gz"
      sha256 "3ef2ebdf6c4bbb55f9ced6953898ed1340c888271e5905762cc5fd432f57b351"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.24/substrate_0.0.24_darwin_amd64.tar.gz"
      sha256 "a2ce509a90fc6b41aad05693f0cceeb7353d8cb8414a27138009fdf1da995e76"
    end
  end
  on_linux do
    depends_on "bubblewrap"
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.24/substrate_0.0.24_linux_arm64.tar.gz"
      sha256 "37d54123a78d92c437ad3f073e350f897950aa9c66a365cb41a6ef6623fa37de"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.24/substrate_0.0.24_linux_amd64.tar.gz"
      sha256 "b00c3fb1f0e91d14fd627f84855bcaed7016bb4ff4689d1769113300441a1171"
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
