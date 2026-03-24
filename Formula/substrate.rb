class Substrate < Formula
  desc "AI-powered work item orchestration for multi-repo development"
  homepage "https://github.com/beeemT/substrate"
  license "MIT"
  version "0.0.1-alpha5"

  depends_on "beeemT/tap/git-work"
  # Optional CLIs intentionally not hard dependencies:
  # - gh: only needed for GitHub CLI token fallback and harness-driven GitHub login
  # - glab: only needed for GitLab MR lifecycle automation

  on_macos do
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha5/substrate_0.0.1-alpha5_darwin_arm64.tar.gz"
      sha256 "b65541cca8f3ae4f7f4b00cae7793f580297700abe830fb85b18419bd91b17cd"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha5/substrate_0.0.1-alpha5_darwin_amd64.tar.gz"
      sha256 "40bc75398b61de5b648b313df61ce0dc11bb6871cd3e0aebe73385d34791273e"
    end
  end
  on_linux do
    depends_on "bubblewrap"
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha5/substrate_0.0.1-alpha5_linux_arm64.tar.gz"
      sha256 "e906095c35dc9d40e4fa5d15caea449fc48c1f15f1c48dbfc012b5591ef463e1"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha5/substrate_0.0.1-alpha5_linux_amd64.tar.gz"
      sha256 "7af2ce3c4c34408fca8e9c0e09d04652b730c8b8c8cd39db11234053c08a2264"
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
