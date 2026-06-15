class Substrate < Formula
  desc "AI-powered work item orchestration for multi-repo development"
  homepage "https://github.com/beeemT/substrate"
  license "MIT"
  version "0.2.6"

  depends_on "beeemT/tap/git-work"
  # Optional CLIs intentionally not hard dependencies:
  # - gh: only needed for GitHub CLI token fallback and harness-driven GitHub login
  # - glab: only needed for GitLab MR lifecycle automation

  on_macos do
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.2.6/substrate_0.2.6_darwin_arm64.tar.gz"
      sha256 "6143909b01eecad0d3d04b31676354a9754a21909fc7c814ba314c0adbdde8b7"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.2.6/substrate_0.2.6_darwin_amd64.tar.gz"
      sha256 "95576f4397f4af6e781b41de52f3248792ba8d08ef914602f0ccfbb9389ce44c"
    end
  end
  on_linux do
    depends_on "bubblewrap"
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.2.6/substrate_0.2.6_linux_arm64.tar.gz"
      sha256 "945776810e6ae04db026e3e58704f9002fc338e5ea47962c7def5be2e70e89a6"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.2.6/substrate_0.2.6_linux_amd64.tar.gz"
      sha256 "aba0a6090005cdc79f23e284d321d798996b3fa08cb2e82bc21e7010855857e6"
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
    assert_path_exists pkgshare/"bridge/question-mcp"
    assert_predicate pkgshare/"bridge/question-mcp", :executable?
    assert_match "question-mcp", shell_output("#{pkgshare}/bridge/question-mcp --version", 0)
  end
end
