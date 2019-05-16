#!/usr/bin/env ruby

require "benchmark/ips"

WORK_DIR = File.expand_path(File.join __dir__, "work")
TMP_TINYFILE="#{WORK_DIR}/rbmactax_tinyfile"
TMP_SMALLFILE="#{WORK_DIR}/rbmactax_smallfile"
TMP_MEDIUMFILE="#{WORK_DIR}/rbmactax_mediumfile"
TMP_LARGEFILE="#{WORK_DIR}/rbmactax_largefile"

# Setup
File.write(TMP_TINYFILE, "w") do |f|
  f.write "x" * 20
end
File.write(TMP_SMALLFILE, "w") do |f|
  f.write "x" * 2000
end
File.write(TMP_MEDIUMFILE, "w") do |f|
  f.write "x" * 20_000_000
end
File.write(TMP_LARGEFILE, "w") do |f|
  f.write "x" * 200_000_000
end

def trivial_calc(t)
  big_num = 1_000_000_000
  counter = big_num
  t.times do
    counter *= counter + big_num
  end
end

# Finished setup, get ready to time stuff
GC.start

Benchmark.ips do |x|
  x.config time: 20, warmup: 5

  x.report("read tiny file") { File.read TMP_TINYFILE }
  x.report("read small file") { File.read TMP_SMALLFILE }
  x.report("read medium file") { File.read TMP_MEDIUMFILE }
  x.report("read large file") { File.read TMP_LARGEFILE }

  x.report("O(N^2) calculation, 10 iters") { trivial_calc(10) }
  x.report("O(N^2) calculation, 15 iters") { trivial_calc(15) }

  x.compare!
end

File.unlink TMP_TINYFILE
File.unlink TMP_SMALLFILE
File.unlink TMP_MEDIUMFILE
File.unlink TMP_LARGEFILE
