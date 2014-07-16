require 'ostruct'

class Player < OpenStruct
  def self.find_by_id!(id)
    raise "Player with ID '#{id}' not found" if id == 'unknown'
    self.new(player_id: 'aaronha01')
  end
end
