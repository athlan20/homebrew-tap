class Stoneage < Formula
  desc "石器时代 2.5 命令行（TUI）客户端"
  homepage "https://github.com/athlan20/stoneage"
  version "0.2.11"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/athlan20/stoneage/releases/download/v0.2.11/stoneage-client-aarch64-apple-darwin.tar.xz"
      sha256 "ea94130ba2bf030f698539fc195a8b28fc254df94b2b9ff6031e18dae476ab93"
    end
    if Hardware::CPU.intel?
      url "https://github.com/athlan20/stoneage/releases/download/v0.2.11/stoneage-client-x86_64-apple-darwin.tar.xz"
      sha256 "297a4038a21387eeb0f5d8dd3070512f822f94e1078594b18cc95709c6abe323"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/athlan20/stoneage/releases/download/v0.2.11/stoneage-client-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "c07ef810cb548746973f5e5fa389480d3844be41ebfcf7b25bb2410a11c93efe"
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
