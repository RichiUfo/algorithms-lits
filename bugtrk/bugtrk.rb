input_file = "#{File.dirname(__FILE__)}/bugtrk.in"
output_file = "#{File.dirname(__FILE__)}/bugtrk.out"

file = File.open(input_file)

count, width, height = file.readline.split(' ').map(&:to_i)

if width == height
  side_length = Math.sqrt(count.to_f).ceil * height
else
  board = []
  i = 0
  while i < count
    i += 1

    if board[0].nil?
      board[0] = 1
      next
    end

    if (board.min + 1) * width <= (board.size + 1) * height
      board = Array.new(board.size, board.min + 1)
    else
      board[board.size] = board.last
    end
    i += board.size - 1

    p i if (i % 10_000).zero?
  end

  side_length = [board.max * width, board.size * height].max
end

open(output_file, 'w') do |f|
  f << "#{side_length}\n"
end
