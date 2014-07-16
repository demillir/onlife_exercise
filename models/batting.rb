require 'ostruct'

class Batting < OpenStruct
  def self.gather_averages(year:, at_least_at_bats:)
    case year
    when 2009; [self.new(player_id: 'aaronha01', batting_avg: 0.211)]
    else;      [self.new(player_id: 'aaronha01', batting_avg: 0.32 )]
    end
  end
end
