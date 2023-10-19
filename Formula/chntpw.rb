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
    assert_match "chntpw version 1.00 140201, (c) Petter N Hagen
chntpw: change password of a user in a Windows SAM file,
or invoke registry editor. Should handle both 32 and 64 bit windows and
all version from NT3.x to Win8.1
chntpw [OPTIONS] <samfile> [systemfile] [securityfile] [otherreghive] [...]
 -h          This message
 -u <user>   Username or RID (0x3e9 for example) to interactively edit
 -l          list all users in SAM file and exit
 -i          Interactive Menu system
 -e          Registry editor. Now with full write support!
 -d          Enter buffer debugger instead (hex editor), 
 -v          Be a little more verbose (for debuging)
 -L          For scripts, write names of changed files to /tmp/changed
 -N          No allocation mode. Only same length overwrites possible (very safe mode)
 -E          No expand mode, do not expand hive file (safe mode)

Usernames can be given as name or RID (in hex with 0x first)

See readme file on how to get to the registry files, and what they are.
Source/binary freely distributable under GPL v2 license. See README for details.
NOTE: This program is somewhat hackish! You are on your own!
", pipe_output("#{bin}/chntpw", "-h")
  end
end
