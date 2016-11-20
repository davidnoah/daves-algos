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
  i = 2
  while i <= n
    if s[i-1] > "0"
      decodings[i] = decodings[i-1]
    end
    if s[i-2] < '2' || (s[i-2] == '2' && s[i-1] < '7')
      decodings[i] += decodings[i-2]
    end
    i += 1
  end
  decodings[n]
end

def fibs_rec(n)
  if n <= 2
    [0, 1].take(n)
  else
    fibs = fibs_rec(n - 1)
    fibs << fibs[-2] + fibs[-1]
  end
end

def subsets(arr)
  subs = [[]]
  arr.each_index do |i|
    subs << arr[i]
    j = i + 1
    while j < arr.length
      sub = arr[i..j]
      subs << sub
      j += 1
    end
    k = i + 2
    while k < arr.length
      sub = [arr[i]] + arr[k..j]
      subs << sub
      k += 1
    end
  end
  subs
end

def word_morph(start_word,end_word,dict)
  possible_words = []
  File.open(dict).each do |word|
    possible_words << word.chomp if word.chomp.length == start_word.length
  end
  p build_word_chain([start_word],end_word,possible_words)
end


def build_word_chain(word_chain,end_word,possible_words)

  return word_chain+[end_word] if possible_transition?(word_chain.last,end_word)

  possible_words.each do |possible_word|
    if possible_transition?(word_chain.last,possible_word)
      new_word_chain = word_chain.dup << possible_word
      new_possible_words = possible_words.dup - [possible_word]
      return build_word_chain(new_word_chain,end_word,new_possible_words)
    end
  end

  return "Transition not Possible"
end


def possible_transition?(old_word,new_word)
  letter_differences = 0
  0.upto(old_word.length-1) do |idx|
    letter_differences += 1 if old_word[idx] != new_word[idx]
  end
  return letter_differences == 1
end


def pig_latin(str)
  str.split(" ").map {|word| latinify(word)}.join(" ")
end

def latinify(str)
  vowels = ["a", "e", "i", "o" ,"u"]
  if vowels.include?(str[0])
    return str[0...str.length] + "way"
  else
    return str[2..-1] + str[0..1] + "ay" if str[0..1] == "qu"
    until (vowels.include?(str[0]))
      str = str[1..-1] + str[0]
    end
  end
  str + "ay"
end

p pig_latin("i speak pig latin quack")
