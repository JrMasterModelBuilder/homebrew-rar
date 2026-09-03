cask "rar-bin" do
  arch arm: "arm", intel: "x64"
  os macos: "macos", linux: "linux"

  version "7.23"
  sha256 arm:          "68b393c000758d477fde43c955ff7542f12f76f3f5e87cdda923152fc791bd4d",
         intel:        "da1fb3c3d7748136c9b369b683d574b372cb1ed049a634a81f85d93918346d8f",
         x86_64_linux: "759b4b6aa0d9f77131882162951193f3a0e54bf60e1d8dc4255aa308accab588"

  url "https://www.rarlab.com/rar/rar#{os}-#{arch}-#{version.no_dots}.tar.gz"
  name "RAR Archiver"
  desc "Archive manager for data compression and backups"
  homepage "https://www.rarlab.com/"

  on_linux do
    depends_on arch: :x86_64
  end

  on_macos do
    preflight do
      system_command "/usr/bin/xattr",
                     args: ["-dr", "com.apple.quarantine", staged_path],
                     must_succeed: false
    end
  end

  binary "rar/rar"
  binary "rar/unrar"
  artifact "rar/default.sfx", target: "#{HOMEBREW_PREFIX}/lib/default.sfx"
  artifact "rar/rarfiles.lst", target: "#{HOMEBREW_PREFIX}/etc/rarfiles.lst"
end
