require 'benchmark'

task = ARGV[0]
file_path = "./#{task}/#{task}.rb"

abort("#{file_path} not found") unless File.exist?(file_path)

Benchmark.bm do |x|
  x.report do
    require file_path
  end
end
