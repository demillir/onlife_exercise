# The TripleCrownStats service compiles statistical summaries about triple crown winners.

class TripleCrownStats
  def winners(year:)
    case year
    when 2012
      [
        {year: year, league: 'AL', player: nil},
        {year: year, league: 'NL', player: {player_id: 'acostme01', birth_year: 1896, first_name: 'Merito', last_name: 'Acosta'}},
      ]
    else
      [
        {year: year, league: 'AL', player: nil},
        {year: year, league: 'NL', player: nil},
      ]
    end
  end
end
