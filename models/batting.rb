# The Batting class models the collection of batting records.  Client code must load batting data into the
# collection by calling the +Batting.add+ method.

class Batting
  attr_reader :player_id, :year, :league, :team, :at_bats, :runs, :hits, :doubles, :triples, :home_runs, :runs_batted_in

  @@objects = {}

  def initialize(player_id:, year: nil, league: nil, team: nil, at_bats: nil, runs: nil,
                 hits: nil, doubles: nil, triples: nil, home_runs: nil, runs_batted_in: nil)
    @player_id      = player_id
    @year           = year.presence && year.to_i
    @league         = league
    @team           = team
    @at_bats        = at_bats.to_i
    @runs           = runs.to_i
    @hits           = hits.to_i
    @doubles        = doubles.to_i
    @triples        = triples.to_i
    @home_runs      = home_runs.to_i
    @runs_batted_in = runs_batted_in.to_i
  end

  # Takes any number of Batting objects or an array of Batting objects and adds them to the global collection.
  def self.add(*players)
    Array(*players).each { |player|
      key = [player.player_id, player.year, player.team]
      @@objects[key] = player
    }
  end

  # Returns an array of the Batting objects that match the given year and that have at least the given number of at-bats.
  def self.gather_averages(year:, at_least_at_bats:)
    year             = year.to_i
    at_least_at_bats = at_least_at_bats.to_i

    @@objects.values.find_all { |batting|
      batting.year == year &&
        batting.at_bats >= at_least_at_bats &&
        Player.find_by_id(batting.player_id)
    }
  end

  # Returns the floating point result of dividing hits by at-bats.
  def batting_avg
    at_bats > 0 ? (hits.to_f / at_bats) : 0.0
  end
end
