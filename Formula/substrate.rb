class Substrate < Formula
  desc "AI-powered work item orchestration for multi-repo development"
  homepage "https://github.com/beeemT/substrate"
  license "MIT"
  version "0.2.3"

  depends_on "beeemT/tap/git-work"
  # Optional CLIs intentionally not hard dependencies:
  # - gh: only needed for GitHub CLI token fallback and harness-driven GitHub login
  # - glab: only needed for GitLab MR lifecycle automation

  on_macos do
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.2.3/substrate_0.2.3_darwin_arm64.tar.gz"
      sha256 "18611d7cca2f2a3bf8029a18ae02980ab2b78a8893bd08ab0b291f8a84d01a99"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.2.3/substrate_0.2.3_darwin_amd64.tar.gz"
      sha256 "4afad62dfc7bc71a5806ee3a63816f540e505952f68aa0104358593c8c9526d8"
    end
  end
  on_linux do
    depends_on "bubblewrap"
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.2.3/substrate_0.2.3_linux_arm64.tar.gz"
      sha256 "a89c9b327520e2c224202099c88794df18c6653f70022e33ad16f64483eb562b"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.2.3/substrate_0.2.3_linux_amd64.tar.gz"
      sha256 "caf7000d449ea74a145c1ae0495933a304d7e192335a87d94042bce3aeab0a06"
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
    assert_path_exists pkgshare/"bridge/foreman-mcp"
    assert_predicate pkgshare/"bridge/foreman-mcp", :executable?
    assert_match "foreman-mcp", shell_output("#{pkgshare}/bridge/foreman-mcp --version", 0)
  end
end
