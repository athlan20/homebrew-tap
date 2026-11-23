cask "peek" do
  arch arm: "arm64", intel: "x86_64"

  version "0.1.2"
  sha256 arm:   "8963a1895fae951ef3258a666012834467d29b570911743dee5caeda8015bbc3",
         intel: "79759d1800f46b4a4f1740522f0a025e2a0ff9a024675d208c9ddd15f31cfa47"

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
