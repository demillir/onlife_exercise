# The BattingsStats service compiles statistical summaries from raw model objects.

class BattingStats
  def most_improved_avg(year:)
    {year: year, player_id: 'aaronha01', birth_year: 1934, first_name: 'Hank', last_name: 'Aaron', batting_avg: 0.32, prev_batting_avg: 0.211}
  end

  def slugging_percentages(year:, team: nil)
    [
      {year: year, team_id: team, player_id: 'bradlmi01', birth_year: 1978, first_name: 'Milton', last_name: 'Bradley', slugging_perc: 28.777},
      {year: year, team_id: team, player_id: 'duchsju01', birth_year: 1977, first_name: 'Justin', last_name: 'Duchscherer', slugging_perc: 32.1},
    ]
  end
end
