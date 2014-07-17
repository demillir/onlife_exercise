# The TripleCrownStats service compiles statistical summaries about triple crown winners.
# The definition of a triple crown winner comes from the exercise/Dev+Candidate+Exercise.pdf
# file:
#    The player that had the highest batting average AND the most home runs AND the most RBI in their league.
#    “Officially” the batting title (highest league batting average) is based on a minimum of
#    502 plate appearances.The provided dataset does not include plate appearances.
#    It also does not include walks so plate appearances cannot be calculated.
#    Instead, use a constraint of a minimum of 400 at-bats to determine those eligible for the league batting title.

class TripleCrownStats
  # Returns an array of triple crown winner data hashes (one for each league) in the given year.
  # Each data hash looks like:
  #    {year: 2012, league: 'NL', player: {player_id: 'acostme01', birth_year: 1896, first_name: 'Merito', last_name: 'Acosta'}}
  #
  # If there is no winner for a league in the given year, a data hash is still returned, but the +player:+ value
  # will be nil, as in:
  #    {year: 2012, league: 'AL', player: nil}
  def winners(year:)
    %w(AL NL).map { |league|
      winner = winner(year: year, league: league, at_least_at_bats: 400)

      # Assemble a hash table of data about the winner.  If there is no winner, the hash table will be nil.
      winner_hash = winner && {
        player_id:  winner.player_id,
        birth_year: winner.birth_year,
        first_name: winner.first_name,
        last_name:  winner.last_name,
      }

      {
        year:   year,
        league: league,
        player: winner_hash,
      }
    }
  end

  private

  def winner(year:, league:, at_least_at_bats:)
    battings = Batting.find_by(year: year, league: league, at_least_at_bats: at_least_at_bats)
    return nil if battings.empty?

    highest_batting_avg = battings.map(&:batting_avg).max
    most_home_runs      = battings.map(&:home_runs).max
    most_rbi            = battings.map(&:runs_batted_in).max

    winner_batting = battings.find { |batting|
      batting.runs_batted_in == most_rbi &&
        batting.home_runs == most_home_runs &&
        (1000 * batting.batting_avg).to_i == (1000 * highest_batting_avg).to_i
    }

    winner_batting && Player.find_by_id!(winner_batting.player_id)
  end
end
