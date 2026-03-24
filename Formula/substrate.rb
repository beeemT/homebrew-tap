class Substrate < Formula
  desc "AI-powered work item orchestration for multi-repo development"
  homepage "https://github.com/beeemT/substrate"
  license "MIT"
  version "0.0.1-alpha6"

  depends_on "beeemT/tap/git-work"
  # Optional CLIs intentionally not hard dependencies:
  # - gh: only needed for GitHub CLI token fallback and harness-driven GitHub login
  # - glab: only needed for GitLab MR lifecycle automation

  on_macos do
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha6/substrate_0.0.1-alpha6_darwin_arm64.tar.gz"
      sha256 "07bb5b2a4f7595e10817ff0c744cc938c68daf24534ce0969452725504937eac"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha6/substrate_0.0.1-alpha6_darwin_amd64.tar.gz"
      sha256 "c06c1bda99bf12916cf510734ae927f5df54b88b12a7d2e837b8dd249be3b8f2"
    end
  end
  on_linux do
    depends_on "bubblewrap"
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha6/substrate_0.0.1-alpha6_linux_arm64.tar.gz"
      sha256 "62f65d1ff314c0e863322cc856f9c7e8a90cef0b56c07765f1ec345dbd400881"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha6/substrate_0.0.1-alpha6_linux_amd64.tar.gz"
      sha256 "f90f7ca5183458e555edc43938bde31867d5b48a853792deb1562a60e8a74fb8"
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
