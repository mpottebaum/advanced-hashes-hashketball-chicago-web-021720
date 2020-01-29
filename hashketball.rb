def game_hash
  hash = {
    :home => {
      :team_name => "Brooklyn Nets",
      :colors => ["Black", "White"],
      :players => [
        {
          :player_name => "Alan Anderson",
          :number => 0,
          :shoe => 16,
          :points => 22,
          :rebounds => 12,
          :assists => 12,
          :steals => 3,
          :blocks => 1,
          :slam_dunks => 1
        },
        {
          :player_name => "Reggie Evans",
          :number => 30,
          :shoe => 14,
          :points => 12,
          :rebounds => 12,
          :assists => 12,
          :steals => 12,
          :blocks => 12,
          :slam_dunks => 7
        },
        {
          :player_name => "Brook Lopez",
          :number => 11,
          :shoe => 17,
          :points => 17,
          :rebounds => 19,
          :assists => 10,
          :steals => 3,
          :blocks => 1,
          :slam_dunks => 15
        },
        {
          :player_name => "Mason Plumlee",
          :number => 1,
          :shoe => 19,
          :points => 26,
          :rebounds => 11,
          :assists => 6,
          :steals => 3,
          :blocks => 8,
          :slam_dunks => 5
        },
        {
          :player_name => "Jason Terry",
          :number => 31,
          :shoe => 15,
          :points => 19,
          :rebounds => 2,
          :assists => 2,
          :steals => 4,
          :blocks => 11,
          :slam_dunks => 1
        }
        ]
    },
    :away => {
      :team_name => "Charlotte Hornets",
      :colors => ["Turquoise", "Purple"],
      :players => [
        {
          :player_name => "Jeff Adrien",
          :number => 4,
          :shoe => 18,
          :points => 10,
          :rebounds => 1,
          :assists => 1,
          :steals => 2,
          :blocks => 7,
          :slam_dunks => 2
        },
        {
          :player_name => "Bismack Biyombo",
          :number => 0,
          :shoe => 16,
          :points => 12,
          :rebounds => 4,
          :assists => 7,
          :steals => 22,
          :blocks => 15,
          :slam_dunks => 10
        },
        {
          :player_name => "DeSagna Diop",
          :number => 2,
          :shoe => 14,
          :points => 24,
          :rebounds => 12,
          :assists => 12,
          :steals => 4,
          :blocks => 5,
          :slam_dunks => 5
        },
        {
          :player_name => "Ben Gordon",
          :number => 8,
          :shoe => 15,
          :points => 33,
          :rebounds => 3,
          :assists => 2,
          :steals => 1,
          :blocks => 1,
          :slam_dunks => 0
        },
        {
          :player_name => "Kemba Walker",
          :number => 33,
          :shoe => 15,
          :points => 6,
          :rebounds => 12,
          :assists => 12,
          :steals => 7,
          :blocks => 5,
          :slam_dunks => 12
        }
        ]
    }
  }
  hash
end

def search_name(name, hash_array)
  #searches players array of hashes for player name
  #returns player index
  index = hash_array.find_index do |player_hash|
    player_hash[:player_name] == name
  end
  if index == nil
    return false
  end
  index
end

def num_points_scored(name)
  game = game_hash
  game.each_pair do |team, team_hash|
    if search_name(name, team_hash[:players])
      player_index = search_name(name, team_hash[:players])
      points_scored = team_hash[:players][player_index][:points]
      return points_scored
    end
  end
end

def shoe_size(name)
  game = game_hash
  game.each_pair do |team, team_hash|
    if search_name(name, team_hash[:players])
      player_index = search_name(name, team_hash[:players])
      size = team_hash[:players][player_index][:shoe]
      return size
    end
  end
end

def team_colors(team_name)
  game = game_hash
  game.each_pair do |team, team_hash|
    if team_hash[:team_name] == team_name
      return team_hash[:colors]
    end
  end
end

def team_names
  game = game_hash
  names_array = game.reduce([]) do |memo, (key, team_hash)|
    memo << team_hash[:team_name]
    memo
  end
  names_array
end



def array_of_player_numbers(array_of_player_hashes)
  number_array = array_of_player_hashes.map do |player_hash|
    player_hash[:number]
  end
  number_array
end

def player_numbers(team_name)
  game = game_hash
  game.each_pair do |team, team_hash|
    if team_hash[:team_name] == team_name
      number_array = array_of_player_numbers(team_hash[:players])
      return number_array
    end
  end
end

def player_stats(name)
  game = game_hash
  game.each_pair do |team, team_hash|
    if search_name(name, team_hash[:players])
      player_index = search_name(name, team_hash[:players])
      stats_hash = team_hash[:players][player_index].keep_if {|stat, value| value.class == Fixnum}
      return stats_hash
    end
  end
end

def search_for_biggest(hash_array, high_key)
  #searches players array of hashes for largest key value
  #returns player index
  player_hash  = hash_array.max do |hash_a, hash_b|
    hash_a[high_key] <=> hash_b[high_key]
  end
  index = hash_array.index(player_hash)
  index
end

def array_of_biggest_keys(game_set, high_key)
  #returns array with two player hashes
  #each player has the largest value of the designated key for his respective team
  biggest_array = []
  game_set.each_pair do |team, team_hash|
    index = search_for_biggest(team_hash[:players], high_key)
    biggest_array << team_hash[:players][index]
  end
  biggest_array
end

def big_shoe_rebounds
  game = game_hash
  biggest_shoes_array = array_of_biggest_keys(game, :shoe)
  biggest_shoe_index = search_for_biggest(biggest_shoes_array, :shoe)
  biggest_shoes_array[biggest_shoe_index][:rebounds]
end

def most_points_scored
  game = game_hash
  most_points_array = array_of_biggest_keys(game, :points)
  most_points_index = search_for_biggest(most_points_array, :points)
  most_points_array[most_points_index][:player_name]
end

def total_points(array_of_players)
  points_array = array_of_players.map do |player_hash|
    player_hash[:points]
  end
  points_array.sum
end

def winning_team
  game = game_hash
  away_points = total_points(game[:away][:players])
  home_points = total_points(game[:home][:players])
  if home_points > away_points
    return game[:home][:team_name]
  else
    return game[:away][:team_name]
  end
end

def search_for_longest_name(hash_array)
  #searches players array of hashes for longest name
  #returns player with longest name's index
  player_hash  = hash_array.max do |hash_a, hash_b|
    hash_a[:player_name].length <=> hash_b[:player_name].length
  end
  index = hash_array.index(player_hash)
  index
end

def array_of_longest_names(game_set)
  #returns array with two player hashes
  #each player has the longest name for his respective team
  biggest_array = []
  game_set.each_pair do |team, team_hash|
    index = search_for_longest_name(team_hash[:players])
    biggest_array << team_hash[:players][index]
  end
  biggest_array
end

def player_with_longest_name
  game = game_hash
  long_name_array = array_of_longest_names(game)
  longest_name_index = search_for_longest_name(long_name_array)
  long_name_array[longest_name_index][:player_name]
end

def long_name_steals_a_ton?
  game = game_hash
  
  #find player with longest name
  longest_name = player_with_longest_name
  
  #find index of player with most steals
  most_steals_array = array_of_biggest_keys(game, :steals)
  most_steals_index = search_for_biggest(most_steals_array, :steals)
  
  #compare these and return true if the names match
  if longest_name == most_steals_array[most_steals_index][:player_name]
    return true
  else
    return false
  end
end