class GnuBackgammon < Formula
		desc "GNU Backgammon is a program for playing and analyzing the game of backgammon"
		homepage "https://www.gnu.org/software/gnubg/"
		url "https://ftp.gnu.org/gnu/gnubg/gnubg-release-1.08.003-sources.tar.gz"
		sha256 "6f7d969b13cfff786fba90ff8cc5e5d564b97f4f0aa69afe4f3838f18c445979"
		license "GPL-3.0-or-later"

		depends_on "autoconf" => :build
		depends_on "automake" => :build
		depends_on "libtool" => :build
		depends_on "bison" => :build
		depends_on "readline" => :build
		depends_on "pkg-config" => :build
		depends_on "glib"
		depends_on "gtk+"
		depends_on 'gtkglext' => :recommended


		livecheck do
				url "https://ftp.gnu.org/gnu/gnubg/"
				regex(/href=.*?gnubg-release[._-]v?(\d+(?:\.\d+)+)-sources\.t/i)
		end
		
		def install
			ENV["PATH"] = "#{Formula["bison"].opt_bin}:#{ENV["PATH"]}"
			ENV["LDFLAGS"] = "-L#{Formula["readline"].opt_lib}"
			ENV["CPPFLAGS"] = "-I#{Formula["readline"].opt_include}"
			system "./autogen.sh"
			system "./configure", *std_configure_args
			system "make"
			system "make", "install"
		end
    
		test do
				system "#{bin}/gnubg", "--version"
		end
end
