class Substrate < Formula
  desc "AI-powered work item orchestration for multi-repo development"
  homepage "https://github.com/beeemT/substrate"
  license "MIT"
  version "0.0.23"

  depends_on "beeemT/tap/git-work"
  # Optional CLIs intentionally not hard dependencies:
  # - gh: only needed for GitHub CLI token fallback and harness-driven GitHub login
  # - glab: only needed for GitLab MR lifecycle automation

  on_macos do
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.23/substrate_0.0.23_darwin_arm64.tar.gz"
      sha256 "dd35f4101d7c836f87f2e8e0b784c7588c203dbe40f485d82600fae2719e7357"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.23/substrate_0.0.23_darwin_amd64.tar.gz"
      sha256 "252770c3ab7250c9d8bb8825170bb0d32879112186b44144a6a391d9d039b6db"
    end
  end
  on_linux do
    depends_on "bubblewrap"
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.23/substrate_0.0.23_linux_arm64.tar.gz"
      sha256 "78dc83de24bad1bc10caf26404fcecbfabab25fd5cbe4097b2296a96910ac5b3"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.23/substrate_0.0.23_linux_amd64.tar.gz"
      sha256 "ff67fe6eb7e65a15f2a2e504cab55adaad67b6e6fe877db3492eea3f1804a105"
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
