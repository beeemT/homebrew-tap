class Substrate < Formula
  desc "AI-powered work item orchestration for multi-repo development"
  homepage "https://github.com/beeemT/substrate"
  license "MIT"
  version "0.0.25"

  depends_on "beeemT/tap/git-work"
  # Optional CLIs intentionally not hard dependencies:
  # - gh: only needed for GitHub CLI token fallback and harness-driven GitHub login
  # - glab: only needed for GitLab MR lifecycle automation

  on_macos do
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.25/substrate_0.0.25_darwin_arm64.tar.gz"
      sha256 "e05d703b1acfb06613a28da2076c2b58ff7c1d428cabe03977db14be0e0de936"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.25/substrate_0.0.25_darwin_amd64.tar.gz"
      sha256 "f7c44c1dcc553f3bce87526d2aac742be14969292e3476c792c73891d02bd5cf"
    end
  end
  on_linux do
    depends_on "bubblewrap"
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.25/substrate_0.0.25_linux_arm64.tar.gz"
      sha256 "46f2043927be90574efa6ea0d85b455673bd33fd0b8d8638e09f812faaa4ae77"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.25/substrate_0.0.25_linux_amd64.tar.gz"
      sha256 "45b29cabeffcc15aa05d0aa03b1a77cdfc5ca92c809979cf968cd6154d72bf92"
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
