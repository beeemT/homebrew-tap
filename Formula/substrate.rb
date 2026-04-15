class Substrate < Formula
  desc "AI-powered work item orchestration for multi-repo development"
  homepage "https://github.com/beeemT/substrate"
  license "MIT"
  version "0.0.1-alpha22"

  depends_on "beeemT/tap/git-work"
  # Optional CLIs intentionally not hard dependencies:
  # - gh: only needed for GitHub CLI token fallback and harness-driven GitHub login
  # - glab: only needed for GitLab MR lifecycle automation

  on_macos do
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha22/substrate_0.0.1-alpha22_darwin_arm64.tar.gz"
      sha256 "15bf6402dfd76e5482a3964cd4a20829d293b07d570e415595f0802e615be544"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha22/substrate_0.0.1-alpha22_darwin_amd64.tar.gz"
      sha256 "9121c62382677f93d43bb07f0357cfbbf919cf0453b2787fd55646a7a2a5da62"
    end
  end
  on_linux do
    depends_on "bubblewrap"
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha22/substrate_0.0.1-alpha22_linux_arm64.tar.gz"
      sha256 "35a7d4a8fbe7d3de7f1cae88f14fd482af2dee97c79d23da79f3da5b9dfe84d9"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha22/substrate_0.0.1-alpha22_linux_amd64.tar.gz"
      sha256 "30b673ac4883d63c459f9637de939e222efcbefb3fcfd93505f9ff81c43ea05b"
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
