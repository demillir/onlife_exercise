# The BattingLoader class is responsible for stuffing the global Batting collection with data from a file.
# Client code can load Batting data from a CSV file by calling +BattingLoader.load_csv+

require 'models/batting'
require 'csv'

class BattingLoader
  # Loads the data in the named CSV file into the global Batting collection.
  def self.load_csv(filename)
    # Validate the header row of the CSV file.
    CSV.foreach(filename) do |row|
      expected_headers = %w(playerID yearID league teamID AB R H 2B 3B HR RBI)
      unless (expected_headers - row).empty?
        raise "File #{filename} has invalid CSV column headers, should be #{expected_headers}"
      end
      break
    end

    # Load the CSV file by converting each row to a Batting object.
    CSV.foreach(filename, headers: true) do |row|
      next unless row['playerID'].present?

      batting = Batting.new(
        player_id:      row['playerID'],
        year:           row['yearID'].presence && row['yearID'].to_i,
        league:         row['league'],
        team:           row['teamID'],
        at_bats:        row['AB'],
        runs:           row['R'],
        hits:           row['H'],
        doubles:        row['2B'],
        triples:        row['3B'],
        home_runs:      row['HR'],
        runs_batted_in: row['RBI']
      )
      Batting.add(batting)
    end
  end
end
