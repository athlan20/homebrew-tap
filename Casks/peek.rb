cask "peek" do
  arch arm: "arm64", intel: "x86_64"

  version "0.1.7"
  sha256 arm:   "d4748c1350b8bbd38c2a99469a6e7239f608ac068d98dc0d2cffcd62ff1a0c83",
         intel: "b4452a70bbc61829fe6e8f1eabf92dc593d2830dc8dda5b68a0bc23b38c417e9"

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
