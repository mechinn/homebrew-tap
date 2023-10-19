class Chntpw < Formula
  desc "Offline Windows Password Editor"
  homepage "https://pogostick.net/~pnh/ntpasswd/"
  url "https://github.com/mechinn/chntpw/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "886d97ed85a0d9c34e1af3e5c861f48fa6c0161530059f553f77168639d3f3a2"
  license all_of: ["LGPL-2.1-only", "GPL-2.0-only"]

  depends_on "cmake" => :build
  depends_on "gcc" => :build
  depends_on "openssl@3"

  def install
    system "cmake", "-S", ".", "-B", "build", "-DOPENSSL_ROOT_DIR=#{Formula["openssl@3"].opt_prefix}", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    assert_match "test brew", pipe_output("#{bin}/chntpw", "test brew")
  end
end
