class Substrate < Formula
  desc "AI-powered work item orchestration for multi-repo development"
  homepage "https://github.com/beeemT/substrate"
  license "MIT"
  version "0.0.1-alpha12"

  depends_on "beeemT/tap/git-work"
  # Optional CLIs intentionally not hard dependencies:
  # - gh: only needed for GitHub CLI token fallback and harness-driven GitHub login
  # - glab: only needed for GitLab MR lifecycle automation

  on_macos do
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha12/substrate_0.0.1-alpha12_darwin_arm64.tar.gz"
      sha256 "c4b7c6142b1ff9722df7d1ce1c64797772bd879199298802ffba0ece67dc4c21"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha12/substrate_0.0.1-alpha12_darwin_amd64.tar.gz"
      sha256 "9a38240fb893e0bef052aa2a2d50c57383056f82b667f409b9e988b534e83a21"
    end
  end
  on_linux do
    depends_on "bubblewrap"
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha12/substrate_0.0.1-alpha12_linux_arm64.tar.gz"
      sha256 "200de650d320b6b5a9c34142c5315df57900afb92e2bafe5364c3c43e6d5488b"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha12/substrate_0.0.1-alpha12_linux_amd64.tar.gz"
      sha256 "16f7aacd1fae586f1714b4d1c63327ac223ad71fee05c8edbb854b41f28e8c10"
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
