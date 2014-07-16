require 'pathname'
$: << File.expand_path("../..", Pathname.new(__FILE__).realpath)
ENV['BUNDLE_GEMFILE'] ||= File.expand_path("../../Gemfile", Pathname.new(__FILE__).realpath)
require 'rubygems'
require 'bundler/setup'

require 'minitest/autorun'
require 'active_support/core_ext'
require 'pry'
require 'parsers/player_loader'
require 'parsers/batting_loader'

fixture_dir = File.expand_path("../fixtures", Pathname.new(__FILE__).realpath)
PlayerLoader.load_csv(File.join(fixture_dir, 'player.csv'))
BattingLoader.load_csv(File.join(fixture_dir, 'batting.csv'))
