class Substrate < Formula
  desc "AI-powered work item orchestration for multi-repo development"
  homepage "https://github.com/beeemT/substrate"
  license "MIT"
  version "0.0.1-alpha1"

  depends_on "beeemT/tap/git-work"
  # Optional CLIs intentionally not hard dependencies:
  # - gh: only needed for GitHub CLI token fallback and harness-driven GitHub login
  # - glab: only needed for GitLab MR lifecycle automation

  on_macos do
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha1/substrate_0.0.1-alpha1_darwin_arm64.tar.gz"
      sha256 "6cd532dfff509db9f1ea44873fee14a2033b79b39e3af39c8c586d0ce5a05ce1"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha1/substrate_0.0.1-alpha1_darwin_amd64.tar.gz"
      sha256 "3dd4a9928ae343234babf8394f0ae9290b41b75d58c02e8085d11c287d0e1c82"
    end
  end
  on_linux do
    depends_on "bubblewrap"
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha1/substrate_0.0.1-alpha1_linux_arm64.tar.gz"
      sha256 "883d76c4cfcc8af2016bbd84955663dde373154fbee1aea508209b3f6a7c2bc9"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha1/substrate_0.0.1-alpha1_linux_amd64.tar.gz"
      sha256 "f0de5aa5104b4dc1ea4fcdd6f78cd9d4ab016fbd2586012535b46e66481201c9"
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
