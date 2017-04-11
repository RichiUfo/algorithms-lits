require 'benchmark'
require 'net/http'

task = ARGV[0]
file_path = "./#{task}/#{task}"
executable_file = "#{file_path}.rb"
in_file = "#{file_path}.in"
out_file = "#{file_path}.out"

abort("#{executable_file} not found") unless File.exist?(executable_file)

Benchmark.bm do |x|
  (1..10).each do |n|
    data_num = n.to_s.rjust(2, '0')
    input_data = Net::HTTP.get(
      '80.254.55.156',
      "/#{task}/inputData/#{data_num}.in", '8888'
    )

    f = File.open(in_file, 'wb')
    f.write(input_data)
    f.close

    x.report do
      `ruby #{executable_file}`
    end

    # puts input_data
    puts "#{data_num}.answer - #{File.read(out_file)}"
  end
end
