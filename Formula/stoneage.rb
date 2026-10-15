class Stoneage < Formula
  desc "石器时代 2.5 命令行（TUI）客户端"
  homepage "https://github.com/athlan20/stoneage"
  version "0.1.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/athlan20/stoneage/releases/download/v0.1.5/stoneage-client-aarch64-apple-darwin.tar.xz"
      sha256 "6c613808dd13ad0ee81b936b3bdf051f68f2723115117f7cb5359187c9b4c0c3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/athlan20/stoneage/releases/download/v0.1.5/stoneage-client-x86_64-apple-darwin.tar.xz"
      sha256 "a175636f1e1c872a710c1c86c3063b36d713864d65e0b48a9f7426563162b035"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/athlan20/stoneage/releases/download/v0.1.5/stoneage-client-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "0fe4e368148ba5f5c1feb81275ca4907a5559b82fac62f12e2881a9da934ce12"
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
