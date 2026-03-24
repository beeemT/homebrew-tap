class Substrate < Formula
  desc "AI-powered work item orchestration for multi-repo development"
  homepage "https://github.com/beeemT/substrate"
  license "MIT"
  version "0.0.1-alpha4"

  depends_on "beeemT/tap/git-work"
  # Optional CLIs intentionally not hard dependencies:
  # - gh: only needed for GitHub CLI token fallback and harness-driven GitHub login
  # - glab: only needed for GitLab MR lifecycle automation

  on_macos do
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha4/substrate_0.0.1-alpha4_darwin_arm64.tar.gz"
      sha256 "4982ea959365c41748190deeaba89225857113d5b93cee226592e123632d4d3c"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha4/substrate_0.0.1-alpha4_darwin_amd64.tar.gz"
      sha256 "6be48ee88a70f6063566ddb4f43b086498d886668c792f95cc2fdf3d0a1061ca"
    end
  end
  on_linux do
    depends_on "bubblewrap"
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha4/substrate_0.0.1-alpha4_linux_arm64.tar.gz"
      sha256 "af1a8b6d26d2206bb9d2529c2722a63e8cb5b5c0ca4a4598486d3e08d93e21e2"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha4/substrate_0.0.1-alpha4_linux_amd64.tar.gz"
      sha256 "38db66371848af7785a60ad621bd8b6fa9f5cdb9c520aea829bf4d9827361e2b"
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
