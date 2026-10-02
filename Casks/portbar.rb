cask "portbar" do
  version "0.1.0"
  sha256 "29e2cf0fd0f78b5f42c0c7ef0563837d00ad6fdae5a9ba51b5d94ec4bdedf09e"

  url "https://github.com/1fc0nfig/portbar/releases/download/portbar-v#{version}/portbar-#{version}.dmg"
  name "portbar"
  desc "Menu bar app that shows which dev servers run on which ports"
  homepage "https://portbar.app"

  # release-please tags carry the component prefix: portbar-v1.2.3.
  livecheck do
    url :url
    regex(/^portbar-v?(\d+(?:\.\d+)+)$/i)
    strategy :github_latest
  end

  depends_on macos: ">= :sonoma"

  app "portbar.app"

  # The app is ad-hoc signed until it has a Developer ID. Without this step,
  # Gatekeeper says the app is damaged and refuses to open it.
  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{appdir}/portbar.app"]
  end

  uninstall quit: "com.cernymatyas.portbar"

  zap trash: "~/Library/Preferences/com.cernymatyas.portbar.plist"
end
