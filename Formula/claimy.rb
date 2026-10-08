class Claimy < Formula
  desc "CLI for advisory environment claims"
  homepage "https://github.com/beeemT/claimy"
  version "0.0.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/beeemT/claimy/releases/download/v#{version}/claimy_#{version}_darwin_arm64.tar.gz"
      sha256 "5b71ad44dbd3b809ebdebf6137e8f9c59c7589d22d9890df1cdab5328ed99e55"
    end
    on_intel do
      url "https://github.com/beeemT/claimy/releases/download/v#{version}/claimy_#{version}_darwin_amd64.tar.gz"
      sha256 "1a6c7babc23704a6292b928f7e9fdd88f6387715ee10e259b65751386095365a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/beeemT/claimy/releases/download/v#{version}/claimy_#{version}_linux_arm64.tar.gz"
      sha256 "147e006145a789ed225a7bbb7fb84e552ea6ef7c3fb938f4f7b6a878e6bdb854"
    end
    on_intel do
      url "https://github.com/beeemT/claimy/releases/download/v#{version}/claimy_#{version}_linux_amd64.tar.gz"
      sha256 "9b2e68700ce312d22ecb33343b033813a89bab963b3fe7417d30829cccc04161"
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
