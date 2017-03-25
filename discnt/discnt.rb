def insertion_rsort(array)
  array.each_with_index do |e, i|
    j = i
    while j > 0 && array[j - 1] < e.to_i
      array[j] = array[j - 1]
      j -= 1
    end
    array[j] = e.to_i
  end
end

input_file = "#{File.dirname(__FILE__)}/discnt.in"
output_file = "#{File.dirname(__FILE__)}/discnt.out"

file = File.open(input_file)

prices = file.readline.split(' ')
discount = file.readline.to_f

sorted_prices = insertion_rsort(prices)
discounts_count = (prices.length / 3).floor

sum = 0
sorted_prices.each_with_index do |price, i|
  multiplier = if i + 1 <= discounts_count
                 1 - discount / 100
               else
                 1
               end

  sum += price * multiplier
end

open(output_file, 'w') do |f|
  f << "#{sum}\n"
end
