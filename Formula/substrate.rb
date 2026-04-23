class Substrate < Formula
  desc "AI-powered work item orchestration for multi-repo development"
  homepage "https://github.com/beeemT/substrate"
  license "MIT"
  version "0.0.32"

  depends_on "beeemT/tap/git-work"
  # Optional CLIs intentionally not hard dependencies:
  # - gh: only needed for GitHub CLI token fallback and harness-driven GitHub login
  # - glab: only needed for GitLab MR lifecycle automation

  on_macos do
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.32/substrate_0.0.32_darwin_arm64.tar.gz"
      sha256 "4bf6cd2589e8827db2be1a4f543c82a1d946e6860b02d09ef729aef2bd6455fe"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.32/substrate_0.0.32_darwin_amd64.tar.gz"
      sha256 "7bd9be7a5c72b84b6cc48e18765119246bef714b833bef05b9848141692f588e"
    end
  end
  on_linux do
    depends_on "bubblewrap"
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.32/substrate_0.0.32_linux_arm64.tar.gz"
      sha256 "c80c62f350f44c964eb91f4657c687d12fd168c0795b5297c54445e82de73dfb"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.32/substrate_0.0.32_linux_amd64.tar.gz"
      sha256 "3e21196250243d9cccc440f53909f5e4a687d7e22be40ad5b3c747127c16e05a"
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
