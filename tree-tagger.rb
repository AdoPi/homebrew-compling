class TreeTagger < Formula
  desc "Part-of-speech tagger for many languages"
  homepage "http://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/"
  if Hardware::CPU.arm?
    url "https://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/data/tree-tagger-ARM64-3.2.tar.gz"
    sha256 "b70d1d4cd625b6cbc9768b08c2e38ea35d158bc42954d062656adc76c647d67a"
  else
    url "https://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/data/tree-tagger-MacOSX-3.2.3.tar.gz"
    sha256 "bb8585b8c96cce5132cf69c576fde20f69632da881b12b1926bb4534edef9ce7"
  end

  option "without-english", "Do not install English parameter files."
  option "with-bulgarian", "Install Bulgarian parameter files."
  option "with-dutch", "Install Dutch parameter files."
  option "with-estonian", "Install Estonian parameter files."
  option "with-finnish", "Install Finnish parameter files."
  option "with-french", "Install French parameter files."
  option "with-french-spoken", "Install Spoken French parameter files."
  option "with-galician", "Install Galician parameter files."
  option "with-german", "Install German parameter files."
  option "with-italian", "Install Italian parameter files."
  option "with-latin", "Install Latin parameter files."
  option "with-mongolian", "Install Mongolian parameter files."
  option "with-polish", "Install Polish parameter files."
  option "with-portuguese", "Install Portuguese parameter files."
  option "with-russian", "Install Russian parameter files."
  option "with-slovak", "Install Slovak parameter files."
  option "with-spanish", "Install Spanish parameter files."
  option "with-swahili", "Install Swahili parameter files."

  option "without-english-chunker", "Do not install English chunker parameter files."
  option "with-french-chunker", "Install French chunker parameter files."
  option "with-german-chunker", "Install German chunker parameter files."

  depends_on "wget" => :build

  def install
    system "wget", "http://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/data/tagger-scripts.tar.gz"

    unless build.without? "english"
      system "wget", "https://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/data/english.par.gz"
    end
    if build.with? "bulgarian"
      system "wget", "https://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/data/bulgarian.par.gz"
    end
    system "wget", "https://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/data/dutch.par.gz" if build.with? "dutch"
    if build.with? "estonian"
      system "wget", "https://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/data/estonian.par.gz"
    end
    if build.with? "finnish"
      system "wget", "https://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/data/finnish.par.gz"
    end
    if build.with? "french"
      system "wget", "https://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/data/french.par.gz"
    end
    if build.with? "french-spoken"
      system "wget", "https://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/data/french-spoken.par.gz"
    end
    if build.with? "galician"
      system "wget", "https://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/data/galician.par.gz"
    end
    if build.with? "german"
      system "wget", "https://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/data/german.par.gz"
    end
    if build.with? "italian"
      system "wget", "https://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/data/italian.par.gz"
    end
    system "wget", "https://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/data/latin.par.gz" if build.with? "latin"
    if build.with? "mongolian"
      system "wget", "https://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/data/mongolian.par.gz"
    end
    if build.with? "polish"
      system "wget", "https://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/data/polish.par.gz"
    end
    if build.with? "portuguese"
      system "wget", "https://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/data/portuguese.par.gz"
    end
    if build.with? "russian"
      system "wget", "https://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/data/russian.par.gz"
    end
    if build.with? "slovak"
      system "wget", "https://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/data/slovak.par.gz"
    end
    if build.with? "spanish"
      system "wget", "https://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/data/spanish.par.gz"
    end
    if build.with? "swahili"
      system "wget", "https://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/data/swahili.par.gz"
    end

    unless build.without? "english-chunker"
      system "wget", "https://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/data/english-chunker.par.gz"
    end
    if build.with? "french-chunker"
      system "wget", "https://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/data/french-chunker.par.gz"
    end
    if build.with? "german-chunker"
      system "wget", "https://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/data/german-chunker.par.gz"
    end
    if build.with? "spanish-chunker"
      system "wget", "https://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/data/spanish-chunker.par.gz"
    end

    system "wget", "http://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/data/install-tagger.sh"
    system "chmod", "+x", "./install-tagger.sh"
    system "./install-tagger.sh"

    Dir["cmd/*"].each do |cmd_file|
      inreplace cmd_file do |cmd_text|
        cmd_text.gsub!(/BIN=.*/, "BIN=#{libexec}/bin")
        cmd_text.gsub!(/CMD=.*/, "CMD=#{libexec}/cmd")
        cmd_text.gsub!(/LIB=.*/, "LIB=#{libexec}/lib")
      end
      rescue
      # uncoment to enable verbose mode:
      # puts "Warning: lines to replace not found in #{cmd_file}"
    end

    rm "install-tagger.sh"

    libexec.install Dir["*"]
    bin.install_symlink Dir["#{libexec}/bin/*"]
    bin.install_symlink Dir["#{libexec}/cmd/*"]
  end

  def caveats
    <<~EOS
      You may want to add to your path
        #{libexec}/bin
      and
        #{libexec}/cmd.
    EOS
  end

  test do
    system "false"
  end
end
