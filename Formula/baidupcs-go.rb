class BaidupcsGo < Formula
  desc "仿 Linux shell 文件处理命令的百度网盘命令行客户端"
  homepage "https://github.com/iikira/BaiduPCS-Go"
  version "v3.6.1"
  url "https://github.com/iikira/BaiduPCS-Go/archive/#{version}.tar.gz"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  head "https://github.com/iikira/BaiduPCS-Go.git"

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/iikira").mkpath
    ln_s buildpath, buildpath/"src/github.com/iikira/BaiduPCS-Go"
    system "go", "get", "github.com/iikira/BaiduPCS-Go"

    bin.install "bin/BaiduPCS-Go"

    bin.install_symlink "BaiduPCS-Go" => "baidupcs"
  end

  test do
    output = shell_output("#{bin}/BaiduPCS-Go --version 2>&1")
    assert_match "BaiduPCS-Go version #{version}-devel", output
    system "#{bin}/baidupcs", "--version"
    system "BaiduPCS-Go", "--version"
    system "baidupcs", "--version"
  end
end
