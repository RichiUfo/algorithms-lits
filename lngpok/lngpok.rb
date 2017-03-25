require 'byebug'

def place_sequence(sequences_id, index)
  sequences = ObjectSpace._id2ref(sequences_id)
  i = index
  while i >= 0
    if sequences[index].length == sequences[i].length || i.zero?
      swap_sequences(sequences_id, i, index)
    end
    i -= 1
  end
end

def swap_sequences(sequences_id, i, j)
  sequences = ObjectSpace._id2ref(sequences_id)
  tmp = sequences[i]
  sequences[i] = sequences[j]
  sequences[j] = tmp
end

input_file = "#{File.dirname(__FILE__)}/lngpok.in"
output_file = "#{File.dirname(__FILE__)}/lngpok.out"
cards = File.open(input_file).readline.split(' ').map(&:to_i)

sequences = []
jokers_count = 0
max_sequence_length = 0

cards.each do |element|
  if element.zero?
    jokers_count += 1
    next
  end

  if sequences.empty?
    sequences.push [element]
    next
  end

  sequences.each_with_index do |sequence, i|
    # if the same elements is already in sequence
    break if element >= sequence.first && element <= sequence.last

    unless element + 1 == sequence.first || element - 1 == sequence.last
      next unless i == sequences.length - 1

      sequences.push [element]
      break
    end

    if element + 1 == sequence.first
      sequence.unshift element
    elsif element - 1 == sequence.last
      sequence << element
    end

    if sequences[i - 1].length < sequence.length
      place_sequence(sequences.object_id, i)
    end

    break
  end
end

sequences.each_with_index do |sequence, i|
  jokers_left = jokers_count
  min = sequence.first
  max = sequence.last
  length = sequence.length

  sequences.each_with_index do |inner_sequence, j|
    next if i == j

    end_discrepancy = inner_sequence.first - max - 1
    start_discrepancy = min - inner_sequence.last - 1

    if end_discrepancy.positive? && end_discrepancy <= jokers_left
      jokers_left -= end_discrepancy
      max = inner_sequence.last
      length += end_discrepancy + inner_sequence.length
    elsif start_discrepancy.positive? && start_discrepancy <= jokers_left
      jokers_left -= start_discrepancy
      min = inner_sequence.first
      length += start_discrepancy + inner_sequence.length
    end
  end

  length += length if jokers_left.positive?
  max_sequence_length = length if length > max_sequence_length
end

open(output_file, 'w') do |f|
  f << "#{max_sequence_length}\n"
end
