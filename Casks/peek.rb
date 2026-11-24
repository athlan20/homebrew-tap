cask "peek" do
  arch arm: "arm64", intel: "x86_64"

  version "0.1.5"
  sha256 arm:   "fd880d7c002582c0b409acf21a7f46f8d78c30e12ea115b54a67ad3c6f94a938",
         intel: "7d448eb3d42939914d46b77371bc4c0c7ccdc34d022374af851ae50842b49a0a"

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
