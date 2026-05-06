class Md2img < Formula
  desc "Convert Markdown to styled PNG images"
  homepage "https://github.com/jmaciasluque/md2img"
  version "1.0.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jmaciasluque/md2img/releases/download/v#{version}/md2img-darwin-arm64.tar.gz"
      sha256 "d50ca411daa2f3c63338ee7df519d172add775a594b12aa337e8b742694acfe0"
    else
      url "https://github.com/jmaciasluque/md2img/releases/download/v#{version}/md2img-darwin-amd64.tar.gz"
      sha256 "f10f6cc2d139017a08005460805a6a6f66f9048048612887ea4b031a1da53cb9"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/jmaciasluque/md2img/releases/download/v#{version}/md2img-linux-arm64.tar.gz"
      sha256 "8726ed9c474914db8c20bae47d1d4a5fefdf3faf759062b0b64647daba5e43f3"
    else
      url "https://github.com/jmaciasluque/md2img/releases/download/v#{version}/md2img-linux-amd64.tar.gz"
      sha256 "962fefe1f22cfb026562ecc5ec461b49e73d394483d12255697713c0be78443b"
    end
  end

  depends_on "ghostscript"

  def install
    bin.install "md2img"
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
