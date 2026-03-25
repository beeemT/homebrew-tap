class Substrate < Formula
  desc "AI-powered work item orchestration for multi-repo development"
  homepage "https://github.com/beeemT/substrate"
  license "MIT"
  version "0.0.1-alpha10"

  depends_on "beeemT/tap/git-work"
  # Optional CLIs intentionally not hard dependencies:
  # - gh: only needed for GitHub CLI token fallback and harness-driven GitHub login
  # - glab: only needed for GitLab MR lifecycle automation

  on_macos do
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha10/substrate_0.0.1-alpha10_darwin_arm64.tar.gz"
      sha256 "922405c010610b27057cf710d79c77f750b875cf42738dc00939bc66a4689590"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha10/substrate_0.0.1-alpha10_darwin_amd64.tar.gz"
      sha256 "efc08c2938eaa55fb1fcb0dfb05d1574d7b680667b077f6a42e2df5fbcf12966"
    end
  end
  on_linux do
    depends_on "bubblewrap"
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha10/substrate_0.0.1-alpha10_linux_arm64.tar.gz"
      sha256 "04c53c08d78fb310c4b0cf637b83eb916079c624c54e1c7cffd819448bfd0619"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha10/substrate_0.0.1-alpha10_linux_amd64.tar.gz"
      sha256 "ddab6e157ed4bb248c3e6052a957acb81952a7201d014259cd6281dc8e21e16b"
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
  end
end
