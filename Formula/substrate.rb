class Substrate < Formula
  desc "AI-powered work item orchestration for multi-repo development"
  homepage "https://github.com/beeemT/substrate"
  license "MIT"
  version "0.2.5"

  depends_on "beeemT/tap/git-work"
  # Optional CLIs intentionally not hard dependencies:
  # - gh: only needed for GitHub CLI token fallback and harness-driven GitHub login
  # - glab: only needed for GitLab MR lifecycle automation

  on_macos do
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.2.5/substrate_0.2.5_darwin_arm64.tar.gz"
      sha256 "6dc0b0f6304ced47184238707db47278d0bd31f9405ed9a9af96e5794152f25c"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.2.5/substrate_0.2.5_darwin_amd64.tar.gz"
      sha256 "97391d1e51851787257a965ee671d7dbb1fd40ced94a92d7493696c96da30bc9"
    end
  end
  on_linux do
    depends_on "bubblewrap"
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.2.5/substrate_0.2.5_linux_arm64.tar.gz"
      sha256 "d213c195abc66d533d9d0f0a0049d2bfd1eb164d0018a9309bd5da42fb133d93"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.2.5/substrate_0.2.5_linux_amd64.tar.gz"
      sha256 "420907ad5bb43703f0943799d4b03968e14a7f9d97ac10b279d070990e79489b"
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
