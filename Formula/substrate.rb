class Substrate < Formula
  desc "AI-powered work item orchestration for multi-repo development"
  homepage "https://github.com/beeemT/substrate"
  license "MIT"
  version "0.1.0"

  depends_on "beeemT/tap/git-work"
  # Optional CLIs intentionally not hard dependencies:
  # - gh: only needed for GitHub CLI token fallback and harness-driven GitHub login
  # - glab: only needed for GitLab MR lifecycle automation

  on_macos do
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.1.0/substrate_0.1.0_darwin_arm64.tar.gz"
      sha256 "e44cfb69cc2ded62004337d569100f5a098869865eb0a7b74c9f3b1835537c2a"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.1.0/substrate_0.1.0_darwin_amd64.tar.gz"
      sha256 "1bf1a17abf8ba0a3cef4ee6b931d31b6e780d45a1461fe370190705b358e906c"
    end
  end
  on_linux do
    depends_on "bubblewrap"
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.1.0/substrate_0.1.0_linux_arm64.tar.gz"
      sha256 "5ad268fe0e688fa3d5ae4c7a4cb526391b28f36163fd9013895274fd8043605d"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.1.0/substrate_0.1.0_linux_amd64.tar.gz"
      sha256 "35a4352b3ad6193c8155f6691701a4cd044f20ab9c4b179326873c7c6add6498"
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
