cask "nocturnal" do
  version "1.0.0"
  sha256 "2f1b3ad6ae6926ac9d3bab4718d4182a53fb1c08ea20142844b6422767e8eb17"

  url "https://nocturnal.tools/downloads/Nocturnal-#{version}-mac.zip"
  name "Nocturnal"
  desc "Keeps a Mac awake with the lid closed while AI agents work, then lets it sleep"
  homepage "https://nocturnal.tools/"

  depends_on macos: ">= :sonoma"

  app "Nocturnal.app"
  # The same binary is the command-line tool when it's run as "nocturnal".
  binary "#{appdir}/Nocturnal.app/Contents/MacOS/Nocturnal", target: "nocturnal"

  # Quitting puts back everything Nocturnal changed (sleep, Low Power Mode, screen, paused apps).
  uninstall quit: "com.alexander.Nocturnal"

  zap trash: [
    "~/Library/Application Support/Nocturnal",
    "~/Library/LaunchAgents/com.alexander.nocturnal.watchdog.plist",
    "~/Library/Preferences/com.alexander.Nocturnal.plist",
  ]

  caveats <<~EOS
    Open Nocturnal once to finish setup (it asks for your password one time to allow only
    the pmset commands it needs). Settings › General › Remove Nocturnal takes that out again.
  EOS
end
