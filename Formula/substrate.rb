class Substrate < Formula
  desc "AI-powered work item orchestration for multi-repo development"
  homepage "https://github.com/beeemT/substrate"
  license "MIT"
  version "0.2.4"

  depends_on "beeemT/tap/git-work"
  # Optional CLIs intentionally not hard dependencies:
  # - gh: only needed for GitHub CLI token fallback and harness-driven GitHub login
  # - glab: only needed for GitLab MR lifecycle automation

  on_macos do
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.2.4/substrate_0.2.4_darwin_arm64.tar.gz"
      sha256 "96eae8a94458c38011baf9a8c3c2ccc7ab3627cff9d551bc7fbdacdb9d182f33"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.2.4/substrate_0.2.4_darwin_amd64.tar.gz"
      sha256 "0effd15ac1cde6d4cf8efa0379323863614eef52b5fb7325559879140ab207ec"
    end
  end
  on_linux do
    depends_on "bubblewrap"
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.2.4/substrate_0.2.4_linux_arm64.tar.gz"
      sha256 "e209c33a134e6258467f0538b3a54729b0ad1ee8db37a35fc3687ca49c3f4b5f"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.2.4/substrate_0.2.4_linux_amd64.tar.gz"
      sha256 "1478b7c39f399bbcbc277a52d052afd966c5fecea4eda1c39e14f7ac123cc27d"
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
