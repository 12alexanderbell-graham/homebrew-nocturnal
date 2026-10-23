cask "nocturnal" do
  version "1.0.0"
  sha256 "d27be07a3220e5aad428cc4a1ad7fa1bac16d61dc243fb99a3f1b52433ef6c53"

  url "https://nocturnal.tools/downloads/Nocturnal-#{version}-mac.zip"
  name "Nocturnal"
  desc "Keeps a Mac awake with the lid closed while AI agents work, then lets it sleep"
  homepage "https://nocturnal.tools/"

  depends_on macos: ">= :sonoma"

  app "Nocturnal.app"
  # The same binary is the command-line tool when it's run as "nocturnal".
  binary "#{appdir}/Nocturnal.app/Contents/MacOS/Nocturnal", target: "nocturnal"

  # Quitting puts back everything Nocturnal changed (sleep, Low Power Mode, screen, paused apps). The watchdog is
  # deliberately left running: once the app has been gone for 10 minutes it removes Nocturnal's sudoers rule and
  # itself, and an upgrade (which also runs this) doesn't cost a new password prompt.
  uninstall quit: "com.alexander.Nocturnal"

  zap launchctl: "com.alexander.nocturnal.watchdog",
      delete:    "/private/etc/sudoers.d/nocturnal",
      trash:     [
        "~/Library/Application Support/Nocturnal",
        "~/Library/LaunchAgents/com.alexander.nocturnal.watchdog.plist",
        "~/Library/Preferences/com.alexander.Nocturnal.plist",
      ]

  caveats <<~EOS
    Open Nocturnal once to finish setup (it asks for your password one time to allow only
    the pmset and tmutil commands it needs).

    To remove everything at once, use Settings › General › Remove Nocturnal before
    `brew uninstall`. Otherwise the leftover watchdog takes the sudoers rule out within
    10 minutes of the app being removed.
  EOS
end
