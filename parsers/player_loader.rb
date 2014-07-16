# The PlayerLoader class is responsible for stuffing the global Player collection with data from a file.
# Client code can load Player data from a CSV file by calling +PlayerLoader.load_csv+

require 'models/player'
require 'csv'

class PlayerLoader
  # Loads the data in the named CSV file into the global Player collection.
  def self.load_csv(filename)
    # Validate the header row of the CSV file.
    CSV.foreach(filename) do |row|
      expected_headers = %w(playerID birthYear nameFirst nameLast)
      unless (expected_headers - row).empty?
        raise "File #{filename} has invalid CSV column headers, should be #{expected_headers}"
      end
      break
    end

    # Load the CSV file by converting each row to a Player object.
    CSV.foreach(filename, headers: true) do |row|
      next unless row['playerID'].present?

      player = Player.new(
        player_id:  row['playerID'],
        birth_year: row['birthYear'],
        first_name: row['nameFirst'],
        last_name:  row['nameLast']
      )
      Player.add(player)
    end
  end
end
