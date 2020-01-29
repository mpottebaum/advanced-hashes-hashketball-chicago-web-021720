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

def search_for_biggest_shoe(hash_array)
  #searches players array of hashes for largest shoe size
  #returns player index
  player_hash  = hash_array.max do |hash_a, hash_b|
    hash_a[:shoe] <=> hash_b[:shoe]
  end
  player_hash[:rebounds]
end