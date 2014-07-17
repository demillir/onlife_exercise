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

  # Returns an array of Batting objects that match the given year and/or team and/or league
  # and/or have at least the given number of at-bats.
  def self.find_by(year: nil, team: nil, league: nil, at_least_at_bats: nil)
    @@objects.values.find_all { |batting|
      (year.nil? || batting.year == year.to_i) &&
        (team.nil? || batting.team == team) &&
        (league.nil? || batting.league == league) &&
        (at_least_at_bats.nil? || batting.at_bats >= at_least_at_bats.to_i) &&
        Player.find_by_id(batting.player_id)
    }
  end

  # Returns the floating point result of dividing hits by at-bats.
  def batting_avg
    at_bats > 0 ? (hits.to_f / at_bats) : 0.0
  end

  # Returns the floating point slugging percentage, which is defined as:
  #    100.0 * (singles + 2*doubles + 3*triples + 4*home_runs) / at_bats.
  def slugging_percentage
    at_bats > 0 ? (100.0 * slugging_points / at_bats) : 0.0
  end

  private

  def slugging_points
    singles + 2*doubles + 3*triples + 4*home_runs
  end

  def singles
    hits - doubles - triples - home_runs
  end
end
