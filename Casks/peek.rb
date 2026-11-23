cask "peek" do
  arch arm: "arm64", intel: "x86_64"

  version "0.1.3"
  sha256 arm:   "677fe8af9230fcb67f8c92f214f6c34cfce15197987febca30cf0b936d8c0a3f",
         intel: "06e4e7c44413a61e6e1a6e6ab665530514222c43a072efbb123256adff6a1237"

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
