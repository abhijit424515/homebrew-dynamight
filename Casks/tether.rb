cask "tether" do
  version "1.0.0"
  sha256 "6658a4c6a374b1f20ffc28f9a5b90f851efd589ed0617cf35d9e5cbaada7632b"

  url "https://github.com/abhijit424515/tether/releases/download/v#{version}/Tether-#{version}.zip"
  name "Tether"
  desc "Menu bar app that keeps audio on your preferred input and output devices"
  homepage "https://github.com/abhijit424515/tether"

  depends_on macos: ">= :ventura"

  app "Tether.app"

  # Tether is ad-hoc signed, not notarized, so it must be installed with
  # --no-quarantine or Gatekeeper will refuse to launch it.
  caveats <<~EOS
    Tether is ad-hoc signed rather than notarized. Install it with:

      brew install --cask --no-quarantine tether

    If you already installed it without that flag and macOS says the app is
    damaged, clear the quarantine attribute:

      xattr -dr com.apple.quarantine "/Applications/Tether.app"
  EOS

  zap trash: [
    "~/.config/tether.json",
    "~/Library/Preferences/com.local.tether.plist",
  ]
end
