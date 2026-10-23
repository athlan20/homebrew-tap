class Stoneage < Formula
  desc "石器时代 2.5 命令行（TUI）客户端"
  homepage "https://github.com/athlan20/stoneage"
  version "0.2.10"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/athlan20/stoneage/releases/download/v0.2.10/stoneage-client-aarch64-apple-darwin.tar.xz"
      sha256 "fcc994608a09097530eb54ac683291f3862646046af4ba04d408ffcf53beb568"
    end
    if Hardware::CPU.intel?
      url "https://github.com/athlan20/stoneage/releases/download/v0.2.10/stoneage-client-x86_64-apple-darwin.tar.xz"
      sha256 "6afafb9315e7c0853688bd10302c497691ca3fb8114c2a47094d0361101e8353"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/athlan20/stoneage/releases/download/v0.2.10/stoneage-client-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "4e6efc35771815d357b7f9fb986c21b5b7e5d7f95165bf442f1118d7e06dcd3e"
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
