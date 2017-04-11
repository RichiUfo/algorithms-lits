
input_file = "#{File.dirname(__FILE__)}/hamstr.in"
# output_file = "#{File.dirname(__FILE__)}/hamstr.out"

file = File.open(input_file)
file_content = file.read.split("\n")

food = file_content.shift
max_hamsters_count = file_content.shift
hamsters = file_content.map do |ham|
  hamster = ham.split ' '
  { consumption: hamster[0], greed: hamster[1] }
end
p hamsters

def min_consumption_for_hamsters_count(hamsters, count)
  count = hamsters.size if hamsters.size < count
  lowest = []

  hamsters.each do |hamster|
    consumption = hamster[:consumption] + hamster[:greed] *
  end
end

p min_consumption_for_hamsters_count(hamsters, 2)



# food = file.readline.to_i
# max_hamsters_count = file.readline.to_i

# while(line = file.readline.to_f) do
#   p line
# end
