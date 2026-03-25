class Substrate < Formula
  desc "AI-powered work item orchestration for multi-repo development"
  homepage "https://github.com/beeemT/substrate"
  license "MIT"
  version "0.0.1-alpha7"

  depends_on "beeemT/tap/git-work"
  # Optional CLIs intentionally not hard dependencies:
  # - gh: only needed for GitHub CLI token fallback and harness-driven GitHub login
  # - glab: only needed for GitLab MR lifecycle automation

  on_macos do
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha7/substrate_0.0.1-alpha7_darwin_arm64.tar.gz"
      sha256 "839ea0137555bf461c4cb462bf21c62e452028db8104f0db542fdc2c07afd98f"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha7/substrate_0.0.1-alpha7_darwin_amd64.tar.gz"
      sha256 "be9f2eb364ae6e8ff5917e27d830db2216438cfad503aa5c808f83d4c364d619"
    end
  end
  on_linux do
    depends_on "bubblewrap"
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha7/substrate_0.0.1-alpha7_linux_arm64.tar.gz"
      sha256 "4a312ac3161e54bea5c93426eff444a25a559bcc0a830eb6638acf0d0504bf27"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha7/substrate_0.0.1-alpha7_linux_amd64.tar.gz"
      sha256 "dbda595e82d217697ef0044ef739535bbc9ef27a8d05c7516de3e4072bb3cc73"
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
