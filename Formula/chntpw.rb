class Chntpw < Formula
  desc "Offline Windows Password Editor"
  homepage "https://pogostick.net/~pnh/ntpasswd/"
  url "https://github.com/mechinn/chntpw/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "886d97ed85a0d9c34e1af3e5c861f48fa6c0161530059f553f77168639d3f3a2"
  license all_of: ["LGPL-2.1-only", "GPL-2.0-only"]

  bottle do
    root_url "https://ghcr.io/v2/mechinn/tap"
    sha256 cellar: :any,                 ventura:      "058ac318fefa2c8565aab2819b80118447dcf061eeba0360af1ca18ffb62c161"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "eec5c6f1ee7e7d73d2d2dcd8e09d3acde7b7ca9998ce6838d915935dbb9ef944"
  end

  depends_on "cmake" => :build
  depends_on "gcc" => :build
  depends_on "openssl@3"

  def install
    system "cmake", "-S", ".", "-B", "build", "-DOPENSSL_ROOT_DIR=#{Formula["openssl@3"].opt_prefix}", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    assert pipe_output("#{bin}/chntpw", "-h").start_with?("chntpw version 1.00 140201, (c) Petter N Hagen")
  end
end
