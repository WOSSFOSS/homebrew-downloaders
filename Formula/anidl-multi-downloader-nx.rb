class AnidlMultiDownloaderNx < Formula
  desc "Downloader for Crunchyroll, Hidive, and AnimationDigitalNetwork with CLI and GUI"
  homepage "https://github.com/anidl/multi-downloader-nx"
  url "https://github.com/anidl/multi-downloader-nx/archive/refs/tags/v5.7.0.tar.gz"
  sha256 "579e9d3ab31f3dbc4a9099fe24cce00ba59833a96d01d3aa61effa78e1b1e60a"
  license "MIT"
  head "https://github.com/anidl/multi-downloader-nx.git", branch: "master"

  bottle do
    root_url "https://github.com/WOSSFOSS/homebrew-downloaders/releases/download/anidl-multi-downloader-nx-5.7.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "52e31a53a00fdadcc21f5ac0ffc2d90aa5ed182e10dfa0854c6130052fa3608b"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "6463b59e13c34ad907405dea0cf0b4e857175f669fce8166145daae1ad8c809c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "2f652ddc66eb1a10989e91f8a573f30d03233934695f5fb5c8ef97084bfff428"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8236b041cb30b0b2cdd550dd3c703fd0597d3ac0ebf7cb52adf0988559e5c318"
  end

  depends_on "node" => :build
  depends_on "p7zip" => :build
  depends_on "pnpm" => :build
  depends_on "bento4"
  depends_on "ffmpeg"
  depends_on "mkvtoolnix"

  patch do
    # Patch can be removed once (if) https://github.com/anidl/multi-downloader-nx/pull/1218 is merged
    url "https://github.com/anidl/multi-downloader-nx/commit/f4681098909eb525fd3e9544c31553116f6895f1.patch?full_index=1"
  end

  def install
    os_name = OS.mac? ? "macos" : "linux"
    arch = Hardware::CPU.intel? ? "x64" : "arm64"
    build_suffix = "#{os_name}-#{arch}-cli"

    system "pnpm", "install"
    system "pnpm", "run", "build-#{build_suffix}"
    chmod "u+w", "lib/_builds/multi-downloader-nx-#{build_suffix}/aniDL"
    bin.install "lib/_builds/multi-downloader-nx-#{build_suffix}/aniDL"
  end

  def caveats
    <<~EOS
      aniDL requires the contentDirectory environment variable to be set to a directory containing empty "playready" and "widevine" subdirectories to run any commands.
      To add the current directory as the content directory, you can add the following line to your shell profile (e.g. ~/.bash_profile or ~/.zshrc):

        export contentDirectory="$(pwd)"
    EOS
  end

  test do
    mkdir testpath/"playready"
    mkdir testpath/"widevine"
    ENV["contentDirectory"] = testpath
    system bin/"aniDL", "--service", "crunchy", "--search", "Test"
  end
end
