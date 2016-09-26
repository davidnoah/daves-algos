# require_relative './BinarySearchTree/Binary_search_tree'
# require_relative './LinkedList/linked_list'
require "set"

def dynamic_coins(coins, sum)
  state = 1
  coins_hash = {0 => 0}

  until state > sum
    valid_coins = coins.select {|coin| coin <= state}
    possible_num_coins = {}
    valid_coins.each do |coin|
      possible_num_coins[coin] = coins_hash[state - coin] + 1
    end
    possible_num_coins.each {|k, v| coins_hash[state] = v if v == possible_num_coins.values.min}
    state += 1
  end

  coins_hash[sum]
end


# missing = {facebook: 10, cash: -90}

def stock_ticker(day_one, day_two, trans)
  new_pos = day_one

  trans.each do |transaction|
    transaction.keys.each do |key|
      new_pos[key] += transaction[key]
    end
  end

  needed_trans = []
  day_two.keys.each do |key|
    next if day_two[key] == new_pos[key]
    new_pos[key] ? diff = new_pos[key] : diff = 0
    difference = day_two[key] - diff
    needed_trans << {key => difference}
  end
  needed_trans
end

# day_one_poss = {google: 10, apple: 10, cash: 40}
# day_one_trans = [{apple: -10, cash: 60}]
# day_two_poss = {google: 10, facebook: 10, cash: 10}
# p stock_ticker(day_one_poss, day_two_poss, day_one_trans)

DIGITS = {1 => "one", 2 => "two", 3 => "three", 4 => "four", 5 => "five", 6 => "six", 7 => "seven", 8 => "eight", 9 => "nine"}
TEENS = {10 => "ten", 11 => "eleven", 12 => "twelve", 13 => "thirteen", 14 => "fourteen", 15 => "fifteen", 16 => "sixteen", 17 => "seventeen", 18 => "eighteen", 19 => "nineteen"}
TENS = {20 => "twenty", 30 => "thirty", 40 => "fourty", 50 => "fifty", 60 => "sixty", 70 => "seventy", 80 => "eighty", 90 => "ninety"}
SCALES = {100 => "hundred", 1000 => "thousand", 1_000_000 => "million", 1_000_000_000 => "billion", 1_000_000_000_000 => "trillion"}

def in_words(num)
  if num < 10
    DIGITS[num]
  elsif num < 20
    TEENS[num]
  elsif num < 100
    tens_word = TENS[(num / 10) * 10]
    if num % 10 == 0
      tens_word
    else
      tens_word + " " + in_words(num - ((num / 10) * 10))
    end
  else
    magnitude = SCALES.keys.select {|scale| scale <= num}[-1]
    words = in_words(num / magnitude) + " " + SCALES[magnitude]
    if num % magnitude != 0
      words + " " + in_words(num % magnitude)
    else
      words
    end
  end
end

ARRAY = [{start: 44, end: 45}, {start: 66, end: 72}]
def in_range(time_start, time_end)
  ARRAY.each do |time|
    return false if (time_start >= time[:start] && time_start <= time[:end]) || (time_end <= time[:end] && time_end >= time[:start])
    return false if (time_start <= time[:start] && time_end >= time[:end])
  end
  true
end


class BigNumber
  attr_reader :value, :base

  def initialize(value, base)
    @value = value
    @base = base
  end

  def add(big_number)
    @value.to_i(@base) + big_number.value.to_i(big_number.base)
  end
end

invalid_sudoku = [[1,2,3,4,5,6,7,8,9],
                  [4,5,6,7,8,9,1,2,3],
                  [7,8,9,1,2,3,4,5,6],
                  [6,7,8,9,1,2,3,4,5],
                  [3,4,5,6,7,8,9,1,2],
                  [2,3,4,5,6,7,8,9,1],
                  [8,9,1,2,3,4,5,6,7],
                  [9,1,2,3,4,5,6,7,8],
                  [5,6,7,8,9,1,2,3,4]]

valid_sudoku = [[6,3,9,5,7,4,1,8,2],
                [5,4,1,8,2,9,3,7,6],
                [7,8,2,6,1,3,9,5,4],
                [1,9,8,4,6,7,5,2,3],
                [3,6,5,9,8,2,4,1,7],
                [4,2,7,1,3,5,8,6,9],
                [9,5,6,7,4,8,2,3,1],
                [8,1,3,2,9,6,7,4,5],
                [2,7,4,3,5,1,6,9,8]]

def valid_sudoku(board)
  rows = Hash.new {|h,k| h[k] = Set.new }
  cols = Hash.new {|h,k| h[k] = Set.new }
  boxes = [Hash.new {|h,k| h[k] = Set.new }, Hash.new {|h,k| h[k] = Set.new }, Hash.new {|h,k| h[k] = Set.new }]

  board.each_with_index do |row, idx|
    row_box = idx / 3
    row.each_with_index do |col, idx2|
      col_box = idx2 / 3
      value = board[idx][idx2]
      next if value == 0

      return false if rows[idx].include?(value)
      rows[idx].add(value)

      return false if cols[idx2].include?(value)
      cols[idx2].add(value)

      return false if boxes[row_box][col_box].include?(value)
      boxes[row_box][col_box].add(value)

    end
  end
  true
end


def num_decodings(s, n = nil)
  n = n || s.length
  return 1 if n == 0 || n == 1
  decodings = 0

  if s[n - 1] > "0"
    decodings = num_decodings(s, n - 1)
  end

  if s[n-2] + s[n-1] <= "26"
    decodings += num_decodings(s, n - 2)
  end

  decodings
end

def dp_num_decodings(s)
  n = s.length
  decodings = {}
  decodings[0] = 1
  decodings[1] = 1
  p decodings
  i = 2
  while i <= n
    if s[i-1] > "0"
      decodings[i] = decodings[i-1]
    end
    if s[i-2] < '2' || (s[i-2] == '2' && s[i-1] < '7')
      decodings[i] += decodings[i-2]
    end
    p decodings
    i += 1
  end
  decodings[n]
end

p num_decodings("1234")
p dp_num_decodings("1234")
