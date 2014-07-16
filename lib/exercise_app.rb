# The ExerciseApp class is a singleton command line interface processor implemented with the Thor gem.
# (See https://github.com/erikhuda/thor.)

require 'thor'

class ExerciseApp < Thor
  desc "stats", "Outputs several Major League Baseball statistics"
  method_option :player_data,  desc: 'Player data file', default: 'Master-small.csv'
  method_option :batting_data, desc: 'Batting data file', default: 'Batting-07-12.csv'
  method_option :format,       desc: 'Output format: json, xml, or text', default: 'text'
  method_option :outfile,      desc: 'Output file. If omitted, output goes to the terminal.'
  default_task :stats
  def stats
    puts "stats"
  end
end
