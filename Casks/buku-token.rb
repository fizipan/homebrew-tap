cask "buku-token" do
  version "0.1.0"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"

  url "https://github.com/fizipan/buku-token/releases/download/v#{version}/Buku-Token_#{version}_aarch64.dmg"
  name "Buku Token"
  desc "Menu bar app for the quota and cost of AI coding agents"
  homepage "https://buku-token.vercel.app/"

  depends_on arch: :arm64

  app "Buku Token.app"

  # Not notarized: the app is signed with a self-signed certificate, so macOS would refuse
  # to open it while the download quarantine flag is set.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Buku Token.app"]
  end

  uninstall quit: "local.toolslab.bukutoken"

  zap trash: [
    "~/Library/Application Support/local.toolslab.bukutoken",
    "~/Library/Caches/buku-token",
    "~/Library/Caches/local.toolslab.bukutoken",
    "~/Library/WebKit/buku-token",
    "~/Library/WebKit/local.toolslab.bukutoken",
  ]

  caveats <<~EOS
    Buku Token is not notarized by Apple. This cask removes the download quarantine flag
    from the app so that macOS can open it. Source: https://github.com/fizipan/buku-token

    If you connected Cursor or OpenRouter, press Disconnect in Settings before uninstalling.
    Those Keychain items are not removed with the app.
  EOS
end
