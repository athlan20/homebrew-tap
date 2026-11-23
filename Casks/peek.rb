cask "peek" do
  arch arm: "arm64", intel: "x86_64"

  version "0.1.0"
  sha256 arm:   "99522cf9b6e004f1262ba9b3fde70e302c161be9d93591100c38bd0155cafc49",
         intel: "473c142e21ca497b8e14b7dd0ab497ef0472c1fcae508a79ac5fd2ff6c52fe13"

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
