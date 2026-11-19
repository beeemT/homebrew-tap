class Blackboard < Formula
  desc "Local topic coordination registry for coding agents"
  homepage "https://github.com/beeemT/blackboard"
  license "MIT"
  version "0.0.1"
  on_macos do
    on_arm do
      url "https://github.com/beeemT/blackboard/releases/download/v0.0.1/blackboard_0.0.1_darwin_arm64.tar.gz"
      sha256 "822f7893b1d99af8e0e62d98f3680ba27863458b86eff00d51ff8286deca5403"
    end
    on_intel do
      url "https://github.com/beeemT/blackboard/releases/download/v0.0.1/blackboard_0.0.1_darwin_amd64.tar.gz"
      sha256 "0b30b01a14edc38facd3e0de9d827aa540d56e6985b35732f9a09467781d66bd"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/beeemT/blackboard/releases/download/v0.0.1/blackboard_0.0.1_linux_arm64.tar.gz"
      sha256 "e3dfed2fd528628942e133c5e3a6268e5b1189a67eaea6b13102d18ae67a078d"
    end
    on_intel do
      url "https://github.com/beeemT/blackboard/releases/download/v0.0.1/blackboard_0.0.1_linux_amd64.tar.gz"
      sha256 "2bc411324524b7386b1c966732f6d935d8bd42b66486204c4472a8703b56908a"
    end
  end
  def install
    bin.install "blackboard"
    pkgshare.install "skills"
  end
  test do
    assert_match "blackboard", shell_output("#{bin}/blackboard help")
    assert_match "registry", shell_output("#{bin}/blackboard --db #{testpath}/registry.db status")
    assert_path_exists pkgshare/"skills/blackboard/SKILL.md"
  end
end
