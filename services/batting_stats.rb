# The BattingsStats service compiles statistical summaries from raw model objects.

require 'models/batting'
require 'models/player'

class BattingStats
  # Returns a hash table of information about the player with the most improved batting average for the
  # given year.  The batting average improvement is calculated as the numerical increase from the previous year.
  # For example, if a player had a .222 batting average in 2009 and a .280 batting average in 2010, then the
  # improvement is 0.058.
  #
  # To be a candidate for most-improved, a player must have had at least a certain number of at-bats in both
  # the given year and in the year prior to the given year.  The default threshhold is 200 at-bats, but
  # the caller can specify the threshhold with the +at_lead_at_bats+ argument.
  def most_improved_avg(year:, at_least_at_bats: 200, league: nil)
    # Gather up all the Batting records for the given year and the prior year.
    # Reject the records that don't meet the at-bats requirement.
    # Make a look-up table (LUT) for each year's set of records, keyed by the player ID.
    curr_battings = Batting.find_by(year: year,   at_least_at_bats: at_least_at_bats, league: league).each_with_object({}) { |b, h| h[b.player_id] = b }
    prev_battings = Batting.find_by(year: year-1, at_least_at_bats: at_least_at_bats, league: league).each_with_object({}) { |b, h| h[b.player_id] = b }

    # Extract the IDs of the players that have qualifying Batting records in both the given year and the previous year.
    player_ids = (curr_battings.keys & prev_battings.keys).uniq
    return {} if player_ids.empty?

    # Find the player with the maximum delta in batting average.
    best_player_id = player_ids.max_by { |player_id|
      curr_battings[player_id].batting_avg.to_f - prev_battings[player_id].batting_avg.to_f
    }
    player = Player.find_by_id!(best_player_id)

    # Assemble and return a hash table with the batting average information about the player.
    {
      year:             year,
      player_id:        player.player_id,
      birth_year:       player.birth_year,
      first_name:       player.first_name,
      last_name:        player.last_name,
      batting_avg:      curr_battings[player.player_id].batting_avg.to_f,
      prev_batting_avg: prev_battings[player.player_id].batting_avg.to_f,
    }
  end

  # Returns an array of player data hashes for players having a Batting record for the given year on the given team.
  # If the given team is nil, all teams will be considered.  A player data hash looks like:
  #    {year: year, team_id: team, player_id: 'bradlmi01', birth_year: 1978, first_name: 'Milton', last_name: 'Bradley', slugging_perc: 28.777}
  def slugging_percentages(year:, team: nil)
    Batting.find_by(year: year, team: team).map { |batting|
      player = Player.find_by_id!(batting.player_id)
      {
        year:          batting.year,
        team_id:       batting.team,
        player_id:     player.player_id,
        birth_year:    player.birth_year,
        first_name:    player.first_name,
        last_name:     player.last_name,
        slugging_perc: batting.slugging_percentage
      }
    }
  end
end
