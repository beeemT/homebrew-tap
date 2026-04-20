class Substrate < Formula
  desc "AI-powered work item orchestration for multi-repo development"
  homepage "https://github.com/beeemT/substrate"
  license "MIT"
  version "0.0.28"

  depends_on "beeemT/tap/git-work"
  # Optional CLIs intentionally not hard dependencies:
  # - gh: only needed for GitHub CLI token fallback and harness-driven GitHub login
  # - glab: only needed for GitLab MR lifecycle automation

  on_macos do
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.28/substrate_0.0.28_darwin_arm64.tar.gz"
      sha256 "11d86549ab6c35f1bf017234cdffa77874f61acd2109aa1c74122d175a599d1b"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.28/substrate_0.0.28_darwin_amd64.tar.gz"
      sha256 "2e44758498d19718b7ca782fa21c8d75d74bb87d7d0ee589cf402a9a26457e57"
    end
  end
  on_linux do
    depends_on "bubblewrap"
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.28/substrate_0.0.28_linux_arm64.tar.gz"
      sha256 "2f78f8a05d2db474430e954ef9e481032ee8eae40fc000615c5a7bf6e61860a1"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.28/substrate_0.0.28_linux_amd64.tar.gz"
      sha256 "588cf5becaae56d0a3beff0e42839db72d84ce91934478e0d1390e7573b90ad7"
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
