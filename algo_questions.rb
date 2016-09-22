# require_relative './BinarySearchTree/Binary_search_tree'
# require_relative './LinkedList/linked_list'

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

p BigNumber.new("f", 16).add(BigNumber.new("f", 16))
