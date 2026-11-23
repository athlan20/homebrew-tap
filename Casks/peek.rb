cask "peek" do
  arch arm: "arm64", intel: "x86_64"

  version "0.1.1"
  sha256 arm:   "ce13f29c52fd0b6e3eeaa269eebe32d0fe072317266151f73f32092d71f3e8a5",
         intel: "95ca490a75012a4bdd9f6862ac18af0421e63ff1408ac30b422764f58e31db7f"

  url "https://github.com/athlan20/peek/releases/download/v#{version}/Peek-#{version}-#{arch}.dmg"
  name "Peek"
  desc "Sub-1MB native macOS menubar system monitor, disk analyzer, and app uninstaller"
  homepage "https://github.com/athlan20/peek"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :sonoma"

  app "Peek.app"

  zap trash: [
    "~/Library/Application Support/Peek",
    "~/Library/Preferences/cc.yuntianyou.peek.plist",
    "~/Library/Caches/cc.yuntianyou.peek",
  ]
end
