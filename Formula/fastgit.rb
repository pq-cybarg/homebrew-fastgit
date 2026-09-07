class Fastgit < Formula
  desc "Baremetal C git — hash-agile (SHA-1/SHA-256/384/SHA3), 38/38 CLI verbs"
  homepage "https://github.com/pq-cybarg/fastgit"
  url "https://github.com/pq-cybarg/fastgit/releases/download/v0.1.0/fastgit-v0.1.0-src.tar.gz"
  sha256 "04dad850fb2d86f6adeb4217c3f2b03352ab1d26fe299f242040f02be4d4be8f"
  license "MIT"

  depends_on "cmake" => :build
  depends_on "openssl@3"
  depends_on "zlib"

  def install
    args = %W[
      -DCMAKE_BUILD_TYPE=Release
      -DFASTGIT_ENABLE_WERROR=OFF
      -DFASTGIT_NATIVE_OPT=OFF
      -DFASTGIT_USE_OPENSSL=ON
    ]
    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build", "-j"
    bin.install "build/src/fastgit-cli" => "fastgit"
  end

  test do
    system "#{bin}/fastgit", "--help"
    Dir.mktmpdir do |dir|
      system "#{bin}/fastgit", "init", dir + "/repo"
      File.write(dir + "/repo/file.txt", "hello fastgit\n")
      oid = `#{bin}/fastgit hash-object -w #{dir}/repo/file.txt 2>&1`.strip
      assert_match(/\A[0-9a-f]{40,64}\z/, oid)
    end
  end
end
