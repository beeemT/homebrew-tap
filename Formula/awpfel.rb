class Awpfel < Formula
  desc "On-device AI ghost text for zsh, backed by a managed local Apfel"
  homepage "https://github.com/beeemT/awpfel"
  version "0.2.1"
  license "MIT"

  depends_on "apfel"
  depends_on "jq"
  depends_on "socat"

  depends_on macos: :tahoe
  depends_on arch: :arm64
  on_macos do
    on_arm do
      url "https://github.com/beeemT/awpfel/releases/download/v#{version}/awpfel_#{version}_darwin_arm64.tar.gz"
      sha256 "1b685ed45a0bed65db6920940db2cfd5e260cb6deb1561981e8f6fbb4ace50cb"
    end
  end

  def install
    bin.install "awpfel"
    pkgshare.install Dir["awpfel*.zsh"]
  end

  def caveats
    <<~EOS
      Run `awpfel setup` to configure your shell, then restart your terminal.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/awpfel --version")
  end
end
