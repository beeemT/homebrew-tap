class Substrate < Formula
  desc "AI-powered work item orchestration for multi-repo development"
  homepage "https://github.com/beeemT/substrate"
  license "MIT"
  version "0.0.1-alpha11"

  depends_on "beeemT/tap/git-work"
  # Optional CLIs intentionally not hard dependencies:
  # - gh: only needed for GitHub CLI token fallback and harness-driven GitHub login
  # - glab: only needed for GitLab MR lifecycle automation

  on_macos do
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha11/substrate_0.0.1-alpha11_darwin_arm64.tar.gz"
      sha256 "11d19c062381d4c3584931dcff5c3fc3484324ebf6c4a8b212a41cc4c15b5d8e"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha11/substrate_0.0.1-alpha11_darwin_amd64.tar.gz"
      sha256 "d3d20c21561da2c8289c3ac03b4a9a477630b45b1646cedd4280cd191e070f9c"
    end
  end
  on_linux do
    depends_on "bubblewrap"
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha11/substrate_0.0.1-alpha11_linux_arm64.tar.gz"
      sha256 "b70759c106adc92e0eb9d4eef54516893d4f6458470d3f67b90cde04d9c1ad61"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha11/substrate_0.0.1-alpha11_linux_amd64.tar.gz"
      sha256 "2de56cf1f1a1257296335b69bdba5104e1cbdedf4471befacad67137ae3ef56a"
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
