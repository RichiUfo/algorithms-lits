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

left = 0
right = max_hamsters_count
hamsters_count = 0
while right - left > 2
  hamsters_count = ((left + right).to_f / 2).ceil

  min_consumption = min_consumption_for_hamsters_count(hamsters, hamsters_count)
  if min_consumption > food
    right = hamsters_count % 2 ? hamsters_count : hamsters_count + 1
  elsif min_consumption < food
    left = hamsters_count % 2 ? hamsters_count : hamsters_count - 1
  else
    break
  end
end

(left..right).each do |h_count|
  consumption = min_consumption_for_hamsters_count(hamsters, h_count)
  break if consumption > food
  hamsters_count = h_count
end

open(output_file, 'w') do |f|
  f << "#{hamsters_count}\n"
end
