class Stoneage < Formula
  desc "石器时代 2.5 命令行（TUI）客户端"
  homepage "https://github.com/athlan20/stoneage"
  version "0.1.8"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/athlan20/stoneage/releases/download/v0.1.8/stoneage-client-aarch64-apple-darwin.tar.xz"
      sha256 "a9ee407bf22d957086122e18fd16a9583528f05f6d61bd0ae0db58eb42fee46a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/athlan20/stoneage/releases/download/v0.1.8/stoneage-client-x86_64-apple-darwin.tar.xz"
      sha256 "0a4694c9343cedde4311f05766bb3b0b1ea784bb1d1d0f14ce14512c8e26627b"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/athlan20/stoneage/releases/download/v0.1.8/stoneage-client-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "bddd513ec9ffb7480dbbb3421d85c3b070927bf6cb65f2678562551e5bc3e751"
  end

  BINARY_ALIASES = {
    "aarch64-apple-darwin":     {},
    "x86_64-apple-darwin":      {},
    "x86_64-pc-windows-gnu":    {},
    "x86_64-unknown-linux-gnu": {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "stoneage"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "stoneage"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "stoneage"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
