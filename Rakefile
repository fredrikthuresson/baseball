require "bundler/gem_tasks"
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new('spec')

task :examples do
  require 'baseball'
  Baseball.configure do |config|
    config.storage = Baseball::Storage::Memory.new #default
    config.player_map = [:uid, :birth_year, :first_name, :last_name] #default
    config.player_stat_map = [:uid, :year, :team_abbr, :g, :ab, :r, :h, :doubles, :triples, :hr, :rbi, :sb, :cs] #default
  end

  baseball = Baseball::Base.new
  player_data = Baseball::Import::File.new(:skip_first => true, :file => 'spec/fixtures/players.csv')
  batting_data = Baseball::Import::File.new(:skip_first => true, :file => 'spec/fixtures/batting.csv')

  puts "Baseball Example Usage"
  separator

  puts "Reading players"
  player_data.read
  puts "Reading batting stats"
  batting_data.read

  puts "Parsing player data"
  baseball.parse_player_data(player_data.data)

  puts "Parsing player statistics"
  baseball.parse_player_stats(batting_data.data)

  puts "#{line_break}Top improved Batting averages between 2008 and 2009"
  separator
  baseball.top_improved_batting_averages(:start_year => 2008, :end_year => 2009, :limit => 10).each do |player|
    puts "#{player.name.ljust(30)} #{Baseball.format_percent(player.batting_improvement)}"
  end

  puts "#{line_break}Slugging Percentages for NYA in 2007"
  separator
  puts Baseball.format_percent(Baseball.format_float(baseball.slugging_percentage(:team => "NYA", :year => 2007)))

  puts "#{line_break}Top improved fantasy scores between 2011 and 2012"
  separator
  baseball.top_improved(:start_year => 2011, :end_year => 2012, :limit => 10).each do |player|
    puts "#{player.name.ljust(30)} #{player.fantasy_improvement}"
  end

  puts "#{line_break}Triple Crown 2011 and 2012"
  separator
  for_2011 = baseball.triple_crown(:year => 2011)
  for_2012 = baseball.triple_crown(:year => 2012)
  puts "2011 #{for_2011 ? for_2011.name : 'No Winner'}"
  puts "2012 #{for_2012 ? for_2012.name : 'No Winner, oops, bug hunting time!'}"
end

def line_break
  "\r\n"
end

def separator
  puts "="*50
end

