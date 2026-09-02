cask "tether" do
  version "1.1.0"
  sha256 "5c18b2e926db44c41ca82690e90fa332db381fba8326facb0eb366ba9c35b460"

  url "https://github.com/abhijit424515/tether/releases/download/v#{version}/tether-#{version}.zip"
  name "Tether"
  desc "Menu bar app that keeps audio on your preferred input and output devices"
  homepage "https://github.com/abhijit424515/tether"

  depends_on macos: :ventura

  app "Tether.app"

  # tether is ad-hoc signed rather than notarized, and Homebrew marks everything it
  # downloads as quarantined. Gatekeeper only inspects files carrying that attribute, so
  # clearing it here is what lets the app launch. Homebrew's own --no-quarantine flag was
  # removed in Homebrew 6, which is why this is a postflight rather than an install option.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Tether.app"],
                   sudo: false
  end

  caveats <<~EOS
    tether is ad-hoc signed, not notarized by Apple. This cask clears the quarantine
    attribute on install so macOS will launch it — which means you are trusting this
    source rather than Apple's notary service. The build scripts are in the repository
    if you would rather build it yourself.

    tether shows a live microphone level on its Microphone tab, so macOS will ask for
    microphone permission the first time you open that tab.
  EOS

  zap trash: [
    "~/.config/tether.json",
  ]
end
