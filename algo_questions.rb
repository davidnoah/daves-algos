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


missing = {facebook: 10, cash: -90}

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

day_one_poss = {google: 10, apple: 10, cash: 40}
day_one_trans = [{apple: -10, cash: 60}]
day_two_poss = {google: 10, facebook: 10, cash: 10}
p stock_ticker(day_one_poss, day_two_poss, day_one_trans)
