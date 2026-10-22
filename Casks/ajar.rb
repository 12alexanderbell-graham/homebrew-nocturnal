cask "ajar" do
  version "1.0.0"
  sha256 "8b075f7f6ce853eee267f55957343257d1acd6bdffb705035632ff437f95a0a6"

  url "https://ajar.tools/downloads/Ajar-#{version}-mac.zip"
  name "Ajar"
  desc "Keeps a Mac awake with the lid closed while AI agents work, then lets it sleep"
  homepage "https://ajar.tools/"

  depends_on macos: ">= :sonoma"

  app "Ajar.app"
  # The same binary is the command-line tool when it's run as "ajar".
  binary "#{appdir}/Ajar.app/Contents/MacOS/Ajar", target: "ajar"

  # Quitting puts back everything Ajar changed (sleep, Low Power Mode, screen, paused apps).
  uninstall quit: "com.alexander.Ajar"

  zap trash: [
    "~/Library/Application Support/Ajar",
    "~/Library/LaunchAgents/com.alexander.ajar.watchdog.plist",
    "~/Library/Preferences/com.alexander.Ajar.plist",
  ]

  caveats <<~EOS
    Open Ajar once to finish setup (it asks for your password one time to allow only
    the pmset commands it needs). Settings › Remove Helper takes that out again.
  EOS
end
