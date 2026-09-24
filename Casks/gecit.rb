cask "gecit" do
  version "0.2.1"

  on_macos do
    on_arm do
      sha256 "2f1db4113ec2591a1d28a26466d1aef7a20c0528c405d3a2a8b8064a2f7c17f5"
      url "https://github.com/boratanrikulu/gecit/releases/download/v#{version}/gecit_#{version}_darwin_arm64.tar.gz"
    end
    on_intel do
      sha256 "f9a027038475ee3ccdb7c84eb10d3d911ae53c3900300a37cf683790d42e7bb2"
      url "https://github.com/boratanrikulu/gecit/releases/download/v#{version}/gecit_#{version}_darwin_amd64.tar.gz"
    end
  end

  name "gecit"
  desc "DPI bypass via fake TLS ClientHello injection, with a built-in DoH resolver"
  homepage "https://github.com/boratanrikulu/gecit"

  livecheck do
    skip "Auto-generated on release."
  end

  binary "gecit"

  # gecit has no code-signing certificate, so Gatekeeper refuses to run the
  # downloaded binary until the quarantine flag comes off it.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "gecit"], chdir: "."
  end

  caveats <<~EOS
    gecit needs root:

      sudo gecit run

    It points system DNS at its own DoH resolver and restores the previous
    settings on Ctrl+C. After a crash, run `sudo gecit cleanup`.

    Uninstalling leaves /etc/gecit behind. Remove it with `sudo rm -rf /etc/gecit`.
  EOS
end
