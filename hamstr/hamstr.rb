input_file = "#{File.dirname(__FILE__)}/hamstr.in"
output_file = "#{File.dirname(__FILE__)}/hamstr.out"

file = File.open(input_file)
file_content = file.read.split("\n")

food = file_content.shift.to_i
max_hamsters_count = file_content.shift.to_i
hamsters = file_content.map do |ham|
  hamster = ham.split ' '
  { consumption: hamster[0].to_i, greed: hamster[1].to_i }
end

def min_consumption_for_hamsters_count(hamsters, count)
  consumptions = hamsters.map do |hamster|
    hamster[:consumption] + hamster[:greed] * (count - 1)
  end

  consumptions.min(count).sum
end

hamsters_count = 0
(1..max_hamsters_count).each do |h_count|
  consumption = min_consumption_for_hamsters_count(hamsters, h_count)
  break if consumption > food
  hamsters_count = h_count
end

open(output_file, 'w') do |f|
  f << "#{hamsters_count}\n"
end
