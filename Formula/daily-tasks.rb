class DailyTasks < Formula
  desc "Terminal-first daily task manager with web and mobile companions"
  homepage "https://github.com/jmaciasluque/daily-tasks"
  url "https://github.com/jmaciasluque/daily-tasks/archive/refs/tags/v0.7.1.tar.gz"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
  head "https://github.com/jmaciasluque/daily-tasks.git", branch: "main"

  depends_on "go" => :build

  def install
    version_str = File.read("VERSION").strip
    cd "cli" do
      system "go", "build",
             "-ldflags", "-s -w -X daily-tasks/internal.Version=#{version_str}",
             "-o", bin/"daily-tasks",
             "."
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/daily-tasks --version")
  end
end
