class Substrate < Formula
  desc "AI-powered work item orchestration for multi-repo development"
  homepage "https://github.com/beeemT/substrate"
  license "MIT"
  version "0.1.1"

  depends_on "beeemT/tap/git-work"
  # Optional CLIs intentionally not hard dependencies:
  # - gh: only needed for GitHub CLI token fallback and harness-driven GitHub login
  # - glab: only needed for GitLab MR lifecycle automation

  on_macos do
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.1.1/substrate_0.1.1_darwin_arm64.tar.gz"
      sha256 "b9acc961c47a2f26ebcb3972cb550b712ffa1ada139722cbf3149199ba873796"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.1.1/substrate_0.1.1_darwin_amd64.tar.gz"
      sha256 "77df09172584dfb1a9727cf8061b9c8d21b3c885fd8d6436b79fc5c56a31bd0c"
    end
  end
  on_linux do
    depends_on "bubblewrap"
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.1.1/substrate_0.1.1_linux_arm64.tar.gz"
      sha256 "0b7616e39028b46b934ecbc0d38d0f67311fb9b2d78e42b31896dbb5e4246b23"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.1.1/substrate_0.1.1_linux_amd64.tar.gz"
      sha256 "0b40c297f587d4d0c6e3d693d9a5ad7d91b64cdb6d6c0f9744769ebb58821f9e"
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
