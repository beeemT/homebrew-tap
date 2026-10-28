class Awpfel < Formula
  desc "On-device AI ghost text for zsh, backed by a managed local Apfel"
  homepage "https://github.com/beeemT/awpfel"
  version "0.3.1"
  license "MIT"

  depends_on "apfel"
  depends_on "jq"
  depends_on "socat"

  depends_on macos: :tahoe
  depends_on arch: :arm64
  on_macos do
    on_arm do
      url "https://github.com/beeemT/awpfel/releases/download/v#{version}/awpfel_#{version}_darwin_arm64.tar.gz"
      sha256 "ba18d87d26f3e88d5d145a2d1f4b3a14cf85827fa549f499dd2288e68f1ee746"
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
