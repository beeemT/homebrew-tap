class Substrate < Formula
  desc "AI-powered work item orchestration for multi-repo development"
  homepage "https://github.com/beeemT/substrate"
  license "MIT"
  version "0.0.1-alpha16"

  depends_on "beeemT/tap/git-work"
  # Optional CLIs intentionally not hard dependencies:
  # - gh: only needed for GitHub CLI token fallback and harness-driven GitHub login
  # - glab: only needed for GitLab MR lifecycle automation

  on_macos do
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha16/substrate_0.0.1-alpha16_darwin_arm64.tar.gz"
      sha256 "5295897aad53da404e850984bc49d0ffb2ae5818944b75f4e0218c677813a032"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha16/substrate_0.0.1-alpha16_darwin_amd64.tar.gz"
      sha256 "7879ff5066aba5d4f215f84754829fb26eb29c17e3336dbaebfddffa6b6c8cd2"
    end
  end
  on_linux do
    depends_on "bubblewrap"
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha16/substrate_0.0.1-alpha16_linux_arm64.tar.gz"
      sha256 "a9fd6e8725928fae795c0391089fbfacb1bcca120084cb5ee91ce509e2549809"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha16/substrate_0.0.1-alpha16_linux_amd64.tar.gz"
      sha256 "e8a8d51c52c9045bd28d111c587620ef2e27d18640579742fc96322ac82fd9ee"
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
