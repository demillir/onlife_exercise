# The ExerciseApp class is a singleton command line interface processor implemented with the Thor gem.
# (See https://github.com/erikhuda/thor.)

require 'thor'
require 'lib/exercise_stats'
require 'active_support/builder'
require 'active_support/core_ext'
require 'parsers/player_loader'
require 'parsers/batting_loader'

class ExerciseApp < Thor
  desc "stats", "Outputs several Major League Baseball statistics"
  method_option :player_data,  desc: 'Player data file', default: 'Master-small.csv'
  method_option :batting_data, desc: 'Batting data file', default: 'Batting-07-12.csv'
  method_option :format,       desc: 'Output format: json, xml, or text', default: 'text'
  method_option :outfile,      desc: 'Output file. If omitted, output goes to the terminal.'
  default_task :stats
  def stats
    # Load the input files into memory before compiling any stats.
    PlayerLoader.load_csv(options[:player_data])
    BattingLoader.load_csv(options[:batting_data])

    # Compile and output the stats.
    stats_hash = ExerciseStats.compile
    open_output_file do |f|
      case options[:format].downcase
      when 'json'; f.puts stats_hash.to_json
      when 'xml';  f.puts stats_hash.to_xml(root: 'stats')
      else;        f.puts stats_hash.to_text
      end
    end
  end

  private

  # Calls the given block with an IO object that is open for writing.  If options[:outfile] is present,
  # the IO object will be a file object for the named output file.  Otherwise, the IO object will be STDOUT.
  def open_output_file(&block)
    outfile = options[:outfile]
    if outfile
      File.open(outfile, 'w') { |f| block.call(f) }
    else
      block.call(STDOUT)
    end
  end
end
