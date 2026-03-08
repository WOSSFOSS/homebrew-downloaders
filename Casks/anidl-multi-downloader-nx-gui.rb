cask "anidl-multi-downloader-nx-gui" do
  arch arm: "arm64", intel: "x64"

  version "5.7.0"
  sha256 "4095eeceff56f263ee2bb1dddfb82debf7d252d317f71da14961d9d753efba8f"

  # conflicts_with "anidl-multi-downloader-nx"

  url "https://github.com/anidl/multi-downloader-nx/releases/download/v#{version}/multi-downloader-nx-macos-#{arch}-gui.7z"
  name "anidl-multi-downloader-nx-gui"
  desc "Downloader for Crunchyroll, Hidive, and AnimationDigitalNetwork with CLI and GUI"
  homepage "https://github.com/anidl/multi-downloader-nx"

  # Documentation: https://docs.brew.sh/Brew-Livecheck
  livecheck do
    url :stable
  end

  depends_on macos: ">= :ventura"

  binary "multi-downloader-nx-macos-#{arch}-gui/aniDL"
end
