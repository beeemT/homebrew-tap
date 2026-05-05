class Substrate < Formula
  desc "AI-powered work item orchestration for multi-repo development"
  homepage "https://github.com/beeemT/substrate"
  license "MIT"
  version "0.0.41"

  depends_on "beeemT/tap/git-work"
  # Optional CLIs intentionally not hard dependencies:
  # - gh: only needed for GitHub CLI token fallback and harness-driven GitHub login
  # - glab: only needed for GitLab MR lifecycle automation

  on_macos do
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.41/substrate_0.0.41_darwin_arm64.tar.gz"
      sha256 "dca86ee3d5c9d202b920c9ef10662a1d62a9d392ef14d24eee65430858819583"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.41/substrate_0.0.41_darwin_amd64.tar.gz"
      sha256 "381c1e4bf7b8aa1bc2017f83e973962d15050a8ba4c834222bd25c07dbe7a2df"
    end
  end
  on_linux do
    depends_on "bubblewrap"
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.41/substrate_0.0.41_linux_arm64.tar.gz"
      sha256 "73ee2c1c8d6c92f9054bbeeef3ed134d465394a26e4b64c45e992dac00777db1"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.41/substrate_0.0.41_linux_amd64.tar.gz"
      sha256 "fd387bb4e1bc16446a5556d28c0d1b2eb7515cf57cc1f772c1bdd53305015b41"
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
