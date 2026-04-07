class Substrate < Formula
  desc "AI-powered work item orchestration for multi-repo development"
  homepage "https://github.com/beeemT/substrate"
  license "MIT"
  version "0.0.1-alpha19"

  depends_on "beeemT/tap/git-work"
  # Optional CLIs intentionally not hard dependencies:
  # - gh: only needed for GitHub CLI token fallback and harness-driven GitHub login
  # - glab: only needed for GitLab MR lifecycle automation

  on_macos do
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha19/substrate_0.0.1-alpha19_darwin_arm64.tar.gz"
      sha256 "325577a8a78a21c480ba1f9d0eeaf612694ed0779ca73e46a97a028424b01029"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha19/substrate_0.0.1-alpha19_darwin_amd64.tar.gz"
      sha256 "cb829ee274174eb75e0c1020733ce58bf74ec755687545028a82091efdb93d29"
    end
  end
  on_linux do
    depends_on "bubblewrap"
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha19/substrate_0.0.1-alpha19_linux_arm64.tar.gz"
      sha256 "50b4b92b2a2e3f0a69641f39a2ccdb82446c1aa4565f830fc7c3690132389dea"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha19/substrate_0.0.1-alpha19_linux_amd64.tar.gz"
      sha256 "bade6fc2f4363a461ef853b8dd3d0a41c74f4c8e9a22d1008eb8bad30722bcad"
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
