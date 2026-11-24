cask "peek" do
  arch arm: "arm64", intel: "x86_64"

  version "0.1.6"
  sha256 arm:   "2ccc1ae278e66352f869d3c023702573cf24e6c3f13ce6889cf56bcade4f39e4",
         intel: "029347323b9da6e2a03adafcb052a42f7a98bb10a5c2ae216f4d7ace50b6772b"

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
