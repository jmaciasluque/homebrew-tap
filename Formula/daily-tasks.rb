class DailyTasks < Formula
  desc "Terminal-first daily task manager with web and mobile companions"
  homepage "https://github.com/jmaciasluque/daily-tasks"
  url "https://github.com/jmaciasluque/daily-tasks/archive/refs/tags/v0.7.1.tar.gz"
  sha256 "c64c06d7e8b60a34970a58ed092207f658b31bde0335f5dd77c581bb009b9185"
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
