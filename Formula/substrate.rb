class Substrate < Formula
  desc "AI-powered work item orchestration for multi-repo development"
  homepage "https://github.com/beeemT/substrate"
  license "MIT"
  version "0.2.1"

  depends_on "beeemT/tap/git-work"
  # Optional CLIs intentionally not hard dependencies:
  # - gh: only needed for GitHub CLI token fallback and harness-driven GitHub login
  # - glab: only needed for GitLab MR lifecycle automation

  on_macos do
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.2.1/substrate_0.2.1_darwin_arm64.tar.gz"
      sha256 "d1075150f540f31b64bd4fdbf1a9454b938a17a0ed4596158d6320afe16eee97"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.2.1/substrate_0.2.1_darwin_amd64.tar.gz"
      sha256 "01dc270315bb8e60cceedcdce83cfe64735053455f89e9c9a5fcbe84ecff4d0c"
    end
  end
  on_linux do
    depends_on "bubblewrap"
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.2.1/substrate_0.2.1_linux_arm64.tar.gz"
      sha256 "9725a186979cde1096f501c04fa06f8bb5ee66f986aeb0bdcfff86e7e9b841ae"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.2.1/substrate_0.2.1_linux_amd64.tar.gz"
      sha256 "a3361eb5c77f021132943c07064f925982e47fe2436742eedf23cf58d079ddbf"
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
