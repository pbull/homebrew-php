require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Xdebug < AbstractPhp70Extension
  init
  desc "Provides debugging and profiling capabilities."
  homepage "https://xdebug.org"
  url "https://xdebug.org/files/xdebug-2.6.0.tgz"
  sha256 "b5264cc03bf68fcbb04b97229f96dca505d7b87ec2fb3bd4249896783d29cbdc"
  head "https://github.com/xdebug/xdebug.git"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "7b93673e1f72647bd8d67a2986a8cc9be9f3db1fab9681b343f4ff8fb5305c1a" => :high_sierra
    sha256 "5dec6bbdd3c52145206dab1e67ff5e92c54ea60c3981feeca1b4ee51f204e989" => :sierra
    sha256 "8b7d0b02177a009215d5fecb389c433b3e749584656c6594be5f3e1cc4c53006" => :el_capitan
  end

  def extension_type
    "zend_extension"
  end

  def install
    Dir.chdir "xdebug-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-debug",
                          "--disable-dependency-tracking",
                          "--enable-xdebug"
    system "make"
    prefix.install "modules/xdebug.so"
    write_config_file if build.with? "config-file"
  end
end
