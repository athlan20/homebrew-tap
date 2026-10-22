class Stoneage < Formula
  desc "石器时代 2.5 命令行（TUI）客户端"
  homepage "https://github.com/athlan20/stoneage"
  version "0.2.8"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/athlan20/stoneage/releases/download/v0.2.8/stoneage-client-aarch64-apple-darwin.tar.xz"
      sha256 "f023a2fb336e30315ec060cbfc3252ccad4862ad466a694430785205e65f54d3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/athlan20/stoneage/releases/download/v0.2.8/stoneage-client-x86_64-apple-darwin.tar.xz"
      sha256 "b5acb0718ad759aac64ccb59ff4c5dd7a7afe17b7ad4f4901b4a1cd89c7271f7"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/athlan20/stoneage/releases/download/v0.2.8/stoneage-client-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "454250f435335e3f60db0726c0a084a542273c9ca68ad788539bfda34dd6c418"
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
