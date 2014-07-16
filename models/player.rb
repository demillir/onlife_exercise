# The Player class models the collection of known players.  Client code must load player data into the
# collection by calling the +Player.add+ method.  Once loaded, the data for a player can be retrieved by
# calling the +Player.find_by_id!+ method.

class Player
  attr_reader :player_id, :birth_year, :first_name, :last_name

  @@objects = {}

  def initialize(player_id:, birth_year: nil, first_name: nil, last_name: nil)
    @player_id  = player_id
    @birth_year = birth_year.presence && birth_year.to_i
    @first_name = first_name
    @last_name  = last_name
  end

  # Takes any number of Player objects or an array of Player objects and adds them to the global collection.
  def self.add(*players)
    Array(*players).each { |player| @@objects[player.player_id] = player }
  end

  # Returns the Player object for the given ID.  Returns nil if there is no data for the given ID.
  def self.find_by_id(id)
    @@objects[id]
  end

  # Returns the Player object for the given ID.  Raises a Runtime exception if there is no data for the given ID.
  def self.find_by_id!(id)
    find_by_id(id).tap { |res|
      raise "Player with ID '#{id}' not found" unless res
    }
  end
end
