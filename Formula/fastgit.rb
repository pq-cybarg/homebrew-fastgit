class Fastgit < Formula
  desc "Bare-metal C git reimplementation - hash-agile SHA256/SHA384/SHA3/SHAKE, 38 verbs, pack batch"
  homepage "https://github.com/pq-cybarg/fastgit"
  url "https://github.com/pq-cybarg/fastgit/releases/download/v0.1.1/fastgit-v0.1.1-src.tar.gz"
  sha256 "08203b5306c759d822beb0a1d6345fb8869daf70dd12b747164abb533f41d7f9"
  license "MIT"
  depends_on "cmake" => :build
  depends_on "openssl@3"
  depends_on "zlib"
  depends_on "curl"
  depends_on "libssh"

  def install
    system "cmake", "-S", ".", "-B", "build", "-DCMAKE_BUILD_TYPE=Release", *std_cmake_args
    system "cmake", "--build", "build", "-j", Hardware::CPU.cores.to_s
    bin.install "build/src/fastgit-cli" => "fastgit"
    bin.install "build/src/libfastgit.dylib" if File.exist?("build/src/libfastgit.dylib")
  end

  test do
    system "#{bin}/fastgit", "init", testpath/"repo"
    assert_predicate testpath/"repo/.git/HEAD", :exist?
  end
end
