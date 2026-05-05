class Substrate < Formula
  desc "AI-powered work item orchestration for multi-repo development"
  homepage "https://github.com/beeemT/substrate"
  license "MIT"
  version "0.0.40"

  depends_on "beeemT/tap/git-work"
  # Optional CLIs intentionally not hard dependencies:
  # - gh: only needed for GitHub CLI token fallback and harness-driven GitHub login
  # - glab: only needed for GitLab MR lifecycle automation

  on_macos do
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.40/substrate_0.0.40_darwin_arm64.tar.gz"
      sha256 "4869b00add56561c494366a19625f046a99161e175fc974daf4aa9e2c363e8cb"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.40/substrate_0.0.40_darwin_amd64.tar.gz"
      sha256 "1893c4599b29645a177726a704778706bdcf896d12cfb104ee4f03888edfa188"
    end
  end
  on_linux do
    depends_on "bubblewrap"
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.40/substrate_0.0.40_linux_arm64.tar.gz"
      sha256 "7ec052b8e1788592109d6817594ccfa7836de3b4a787f7e5e3beca27ef3c7cc4"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.40/substrate_0.0.40_linux_amd64.tar.gz"
      sha256 "2659870dec4753182264a6adb62cd3d0700d5e6e8a2576209f2c1a3d82a03757"
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
