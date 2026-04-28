class Substrate < Formula
  desc "AI-powered work item orchestration for multi-repo development"
  homepage "https://github.com/beeemT/substrate"
  license "MIT"
  version "0.0.36"

  depends_on "beeemT/tap/git-work"
  # Optional CLIs intentionally not hard dependencies:
  # - gh: only needed for GitHub CLI token fallback and harness-driven GitHub login
  # - glab: only needed for GitLab MR lifecycle automation

  on_macos do
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.36/substrate_0.0.36_darwin_arm64.tar.gz"
      sha256 "c24abf6399ba965fcfadb363154f1fcaa16016912b94c7892a814e5b629a1ce1"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.36/substrate_0.0.36_darwin_amd64.tar.gz"
      sha256 "4d95bdd3974fc7d16ecfd6daaaaef47d6081d919d367fc318866614eed3913a6"
    end
  end
  on_linux do
    depends_on "bubblewrap"
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.36/substrate_0.0.36_linux_arm64.tar.gz"
      sha256 "33ca3ef301f5b8f761c7c86eb8932750115ff5fd76cd6797250782b5857d85b2"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.36/substrate_0.0.36_linux_amd64.tar.gz"
      sha256 "1120ece1a13b81d17e6634534143081341849f8062696710acaccc7819019e24"
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
