class Claimy < Formula
  desc "CLI for advisory environment claims"
  homepage "https://github.com/beeemT/claimy"
  version "0.0.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/beeemT/claimy/releases/download/v#{version}/claimy_#{version}_darwin_arm64.tar.gz"
      sha256 "487d90053dedbe6e20acbed3ff183e2071fb1e655866f5528534d01ca034e96d"
    end
    on_intel do
      url "https://github.com/beeemT/claimy/releases/download/v#{version}/claimy_#{version}_darwin_amd64.tar.gz"
      sha256 "9f050e60c1c56bd937c9e1507c58c28e0bec0693ba06e0581bdecd1a263f0cb4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/beeemT/claimy/releases/download/v#{version}/claimy_#{version}_linux_arm64.tar.gz"
      sha256 "e32761611baca0bce70a752e6a2cdb6f5150b7944712189c080b18b3858f09b4"
    end
    on_intel do
      url "https://github.com/beeemT/claimy/releases/download/v#{version}/claimy_#{version}_linux_amd64.tar.gz"
      sha256 "f2f40226b286bb8e6e37e6d2680a4504d26d1a5465efd6212a82f855a1c5c07d"
    end
  end

  def install
    bin.install "claimy"
    pkgshare.install "SKILL.md"
  end

  test do
    shell_output "#{bin}/claimy acquire --group test --environments invalid --request-id test 2>&1", 2
  end
end
