class Md2img < Formula
  desc "Convert Markdown to styled PNG images"
  homepage "https://github.com/jmaciasluque/md2img"
  version "1.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jmaciasluque/md2img/releases/download/v#{version}/md2img-darwin-arm64.tar.gz"
      sha256 "f70823083d0ba48814601cefe0257b556e01a51a72e830aae6246da49b47c547"
    else
      url "https://github.com/jmaciasluque/md2img/releases/download/v#{version}/md2img-darwin-amd64.tar.gz"
      sha256 "c4894295612d98f9d78e31dcb043186b24cc38ccdff7029ae15b3dac898fb1e1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/jmaciasluque/md2img/releases/download/v#{version}/md2img-linux-arm64.tar.gz"
      sha256 "a7a217d409250ca2a6b4e47d73480f05b02a2ef2ed6a76d4b41804a5955175cb"
    else
      url "https://github.com/jmaciasluque/md2img/releases/download/v#{version}/md2img-linux-amd64.tar.gz"
      sha256 "c42756456d305d3c5fd60a39e29286e158e86317689bc900757a7b89634e7b3f"
    end
  end

  depends_on "ghostscript"

  def install
    bin.install "md2img-#{OS.mac? ? "darwin" : "linux"}-#{Hardware::CPU.arch}" => "md2img"
  end

  test do
    output = shell_output("#{bin}/md2img -version")
    assert_match "md2img #{version}", output

    # Test rendering
    (testpath/"test.md").write "# Hello\n\n| A | B |\n|---|---|\n| 1 | 2 |"
    system "#{bin}/md2img", "-o", "#{testpath}/output.png", "#{testpath}/test.md"
    assert_predicate testpath/"output.png", :exist?

    # Test PDF output
    system "#{bin}/md2img", "-o", "#{testpath}/output.pdf", "-pdf", "#{testpath}/test.md"
    assert_predicate testpath/"output.pdf", :exist?
  end
end
