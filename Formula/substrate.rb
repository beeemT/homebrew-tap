class Substrate < Formula
  desc "AI-powered work item orchestration for multi-repo development"
  homepage "https://github.com/beeemT/substrate"
  license "MIT"
  version "0.2.2"

  depends_on "beeemT/tap/git-work"
  # Optional CLIs intentionally not hard dependencies:
  # - gh: only needed for GitHub CLI token fallback and harness-driven GitHub login
  # - glab: only needed for GitLab MR lifecycle automation

  on_macos do
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.2.2/substrate_0.2.2_darwin_arm64.tar.gz"
      sha256 "a947794324f2cc26b8f3bfb3458e9f9ace0b837c4ff1c6b18af613b04af5ec32"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.2.2/substrate_0.2.2_darwin_amd64.tar.gz"
      sha256 "58aab89afd7d0f02e481859e7e92d979a054b2e8ad50313d9e01883d9d8c54ff"
    end
  end
  on_linux do
    depends_on "bubblewrap"
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.2.2/substrate_0.2.2_linux_arm64.tar.gz"
      sha256 "adf923dc03c19a1bc9fde9469453596fc1d827c06cd1fffcc6ac3e65ae1038f1"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.2.2/substrate_0.2.2_linux_amd64.tar.gz"
      sha256 "83fcd7e3522aa1906557a86986bce04f70e19e51bfd0e5bfdc816a5a10fc424e"
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
