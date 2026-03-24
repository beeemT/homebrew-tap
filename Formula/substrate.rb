class Substrate < Formula
  desc "AI-powered work item orchestration for multi-repo development"
  homepage "https://github.com/beeemT/substrate"
  license "MIT"
  version "0.0.1-alpha2"

  depends_on "beeemT/tap/git-work"
  # Optional CLIs intentionally not hard dependencies:
  # - gh: only needed for GitHub CLI token fallback and harness-driven GitHub login
  # - glab: only needed for GitLab MR lifecycle automation

  on_macos do
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha2/substrate_0.0.1-alpha2_darwin_arm64.tar.gz"
      sha256 "f1edf4b71bbb450dfeb5844ff4ab5f942bff85718599473fb1dd1473f13dd307"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha2/substrate_0.0.1-alpha2_darwin_amd64.tar.gz"
      sha256 "198270e6f61d18403bf4877c9c6852078bfc6a2dfb1b63a2a3af16cadb39ea19"
    end
  end
  on_linux do
    depends_on "bubblewrap"
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha2/substrate_0.0.1-alpha2_linux_arm64.tar.gz"
      sha256 "6e62765eafb123872df305f0a2b6a2a7adacc1df0d7be6cb582df49843f22701"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha2/substrate_0.0.1-alpha2_linux_amd64.tar.gz"
      sha256 "09df9bccce3e88e54600843804c90746f1c10e2a9f10adbfa87ec9e81a4b5acb"
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
