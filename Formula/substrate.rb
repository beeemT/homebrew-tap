class Substrate < Formula
  desc "AI-powered work item orchestration for multi-repo development"
  homepage "https://github.com/beeemT/substrate"
  license "MIT"
  version "0.0.1-alpha3"

  depends_on "beeemT/tap/git-work"
  # Optional CLIs intentionally not hard dependencies:
  # - gh: only needed for GitHub CLI token fallback and harness-driven GitHub login
  # - glab: only needed for GitLab MR lifecycle automation

  on_macos do
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha3/substrate_0.0.1-alpha3_darwin_arm64.tar.gz"
      sha256 "1e98bb4df216e150a110b12a1711e91804223d9af6e19ead348d10889e5a6363"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha3/substrate_0.0.1-alpha3_darwin_amd64.tar.gz"
      sha256 "b323689620e3f9a7563d8d64fceebf27c9c05f61ca4a9f672440d5c0a106a054"
    end
  end
  on_linux do
    depends_on "bubblewrap"
    on_arm do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha3/substrate_0.0.1-alpha3_linux_arm64.tar.gz"
      sha256 "2e9c8358ef29b8b290e65956cb6a6ae817284c03f26a5c8ef34a186220d0033b"
    end
    on_intel do
      url "https://github.com/beeemT/substrate/releases/download/v0.0.1-alpha3/substrate_0.0.1-alpha3_linux_amd64.tar.gz"
      sha256 "e94eeef1e85badb671521d5548b4d0f2e022145b0af8dc630d7ddba0c0e7f009"
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
