class Substrate < Formula
  desc "AI-powered work item orchestration for multi-repo development"
  homepage "https://github.com/beeemT/substrate"
  license "MIT"
  version "0.0.1-alpha9"

  depends_on "beeemT/tap/git-work"
  # Optional CLIs intentionally not hard dependencies:
  # - gh: only needed for GitHub CLI token fallback and harness-driven GitHub login
  # - glab: only needed for GitLab MR lifecycle automation

  on_macos do
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha9/substrate_0.0.1-alpha9_darwin_arm64.tar.gz"
      sha256 "46b48ea26200e295c606515cf3dcab5e181cdbed0c4c967eea145f301724835a"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha9/substrate_0.0.1-alpha9_darwin_amd64.tar.gz"
      sha256 "e2141b813c58287bad09ed775b91594be768cd4a99929a5256394fca8fa349c8"
    end
  end
  on_linux do
    depends_on "bubblewrap"
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha9/substrate_0.0.1-alpha9_linux_arm64.tar.gz"
      sha256 "f3fec40a9979cf66952ed762c5c07259ea26d6533d740d4b43a7bb8dbc90189e"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha9/substrate_0.0.1-alpha9_linux_amd64.tar.gz"
      sha256 "c68e1f16b6ffc962e7dd804538afb7c8b44c08e2fcc47a8945f44ff5e9b1577b"
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
