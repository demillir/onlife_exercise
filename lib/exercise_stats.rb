# This helper class encapsulates all of the quirky details of the very-specific list of statistics
# for which this application is responsible.  It uses the more generic computation functions of the base
# model classes (Player, Batting, etc) to assemble the quirky statistics.
#
# For example, one of the very-specific statistics that this application must produce is the player with the
# most-improved batting average in just the year 2010.  To create that statistic, this class will delegate to
# the Batting model's generic methods.
#
# Objects from this class are simply plain-old Ruby hash tables with an extra #to_text method.
# The #to_text method knows how to render the the hash table in a human-readable format for display on a terminal.

require 'services/batting_stats'
require 'services/triple_crown_stats'

class ExerciseStats < Hash

  # Returns a hash table of the statistics required by the coding exercise specification in
  # doc/Dev+Candidate+Exercise.pdf.  The returned hash table looks something like:
  #     {most_improved_batting_avg_2010:       {player_id:  "aaronha01", birth_year: 1934, first_name: "Hank", last_name: "Aaron", batting_avg: 0.323, prev_batting_avg: 0.211},
  #      slugging_percentages_Oakland_As_2007: [{player_id:     "bradlmi01", birth_year: 1978, first_name: "Milton", last_name: "Bradley", year: 2007, player: 28.7},
  #                                             {player_id:     "duchsju01", birth_year: 1977, first_name: "Justin", last_name: "Duchscherer", year: 2007, player: 32.1}],
  #      triple_crown_winners:                 [{year: 2011, league: "AL", player: nil},
  #                                             {year: 2011, league: "NL", player: nil},
  #                                             {year: 2012, league: "AL", player: nil},
  #                                             {year:   2012,
  #                                              league: "NL",
  #                                              player: {player_id:  "acostme01", birth_year: 1896, first_name: "Merito", last_name: "Acosta"}}]}
  def self.compile
    # These objects will perform the statistics compilation.
    batting_stats = BattingStats.new
    crown_stats   = TripleCrownStats.new

    # Return a hash table that has been cast as an ExerciseStats object.
    self[
      most_improved_batting_avg_2010:       batting_stats.most_improved_avg(year: 2010),
      slugging_percentages_Oakland_As_2007: batting_stats.slugging_percentages(year: 2007, team: 'OAK'),
      triple_crown_winners:                 crown_stats.winners(year: 2011) + crown_stats.winners(year: 2012),
    ]
  end

  # Renders this statistics hash table to a textual string suitable for display on a terminal.
  def to_text
    result = ''

    # Render the player with the most improved batting average.
    player = self[:most_improved_batting_avg_2010]
    result << "Most Improved Batting Avg from 2009 to 2010: #{player_label(player)}\n"
    result << "   2009 average: #{'%.3f' % player[:prev_batting_avg].to_f}\n"
    result << "   2010 average: #{'%.3f' % player[:batting_avg].to_f}\n"

    # Render the slugging percentages.
    result << "\nOakland Athletic's 2007 Slugging Percentages:\n"
    players = self[:slugging_percentages_Oakland_As_2007]
    sorted_players = players.sort_by { |p| [1000.0 - p[:slugging_perc], p[:last_name].to_s, p[:first_name].to_s, p[:player_id].to_s] }
    sorted_players.each do |plyr|
      formatted_perc = '%5.1f%%' % plyr[:slugging_perc]
      result << "   #{formatted_perc} #{player_label(plyr)}\n"
    end

    # Render the triple crown winners.
    result << "\nTriple Crown Winners:\n"
    winners = self[:triple_crown_winners]
    sorted_winners = winners.sort_by { |p| [p[:year].to_s, p[:league].to_s] }
    sorted_winners.each do |winner|
      player = winner[:player]
      player_lbl = player ? player_label(player) : '(No winner)'
      result << "   #{winner[:year]} -- #{winner[:league]}: #{player_lbl}\n"
    end

    result
  end

  private

  # Renders a unique label for the player described by the given data hash table.  For example:
  #     Hank Aaron (aaronha01)
  def player_label(player_hash)
    return "N/A" unless player_hash.has_key?(:player_id)

    "#{player_hash[:first_name]} #{player_hash[:last_name]} (#{player_hash[:player_id]})"
  end

end
