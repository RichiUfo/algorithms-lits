input_file = "#{File.dirname(__FILE__)}/lngpok.in"
output_file = "#{File.dirname(__FILE__)}/lngpok.out"
cards = File.open(input_file).readline.split(' ').map(&:to_i).sort!

sequences = []
jokers_count = 0
max_sequence_length = 0

cards.each { |card| card.zero? ? jokers_count += 1 : break }
cards.shift(jokers_count)
cards.uniq!

previous_card = nil
cards.each do |card|
  if card - 1 != previous_card
    sequences << [card]
  else
    sequences.last << card
  end

  previous_card = card
end

last_index = sequences.length - 1
sequences.each_index do |i|
  jcount = jokers_count
  sq_length = 0
  loop do
    break if i >= last_index
    sq_diff = (sequences[i + 1].first - sequences[i].last) - 1
    break if sq_diff > jcount

    sq_length += sequences[i].length if sq_length.zero?
    sq_length += sq_diff + sequences[i + 1].length
    jcount -= sq_diff
    i += 1
  end

  max_sequence_length = if sq_length > max_sequence_length
                          sq_length + (jcount > 0 ? jcount : 0)
                        elsif sequences[i].length > max_sequence_length
                          sequences[i].length + (jcount > 0 ? jcount : 0)
                        else
                          max_sequence_length
                        end
end

max_sequence_length = jokers_count if sequences.empty?

open(output_file, 'w') do |f|
  f << "#{max_sequence_length}\n"
end
