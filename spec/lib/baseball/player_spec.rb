require 'spec_helper'

describe Baseball::Player do
  describe "initialize" do
    let(:opts) { {:uid => "frank001", :birth_year => "1944", :first_name => "Frank", :last_name =>  "Baseball"} }
    let(:player) { Baseball::Player.new(opts) }

    it 'should set uid' do
      player.uid.should == "frank001"
    end

    it 'should set birth year' do
      player.birth_year.should == "1944"
    end

    it 'should set player first name' do
      player.first_name.should == "Frank"
    end

    it 'should set player last name' do
      player.last_name.should == "Baseball"
    end

    it 'should have an array of stats' do
      player.stats.should be_instance_of(Array)
    end

    it 'should repond to name' do
      player.name.should == "#{player.first_name} #{player.last_name}"
    end
  end

  describe "player.stats << stat" do
    let(:player_opts) { {:uid => "frank001", :birth_year => "1944", :first_name => "Frank", :last_name =>  "Baseball"} }
    let(:player) { Baseball::Player.new(player_opts) }

    let(:stat_opts) { {:uid => "frank001", :year => "2012", :team_abbr => "NYA", :g => "156", :ab => "609", :r => "100", :h => "180", 
                        :doubles => "39", :singles => "4", :hr => "20", :rbi => "105", :sb => "22", :cs => "11"} }
    let(:stat) { Baseball::Stat.new(opts) }

    it 'should not accept a Class class' do
      expect {
        player.stats << Class.new
      }.to raise_error(ArgumentError, "Player#stats only accepts objects of type Baseball::Stat")
    end

    it 'should accept a Baseball::Stat class' do
      expect {
        player.stats << Baseball::Stat.new(stat_opts)
      }.to_not raise_error
    end

    it 'should store the stat' do
      player.stats.should be_empty
      player.stats << Baseball::Stat.new(stat_opts)
      player.stats.size.should == 1
    end
  end

  describe "#formatting" do
    let(:player_opts) { {:uid => "frank001", :birth_year => "1944", :first_name => "Frank", :last_name =>  "Baseball"} }
    let(:player) { Baseball::Player.new(player_opts) }

    it 'should format batting improvement' do
      player.batting_improvement = 0.12345
      player.batting_improvement.should == 0.123
    end

    it "should format slugging_percentage" do
      player.slugging_percentage = 0.12345
      player.slugging_percentage.should == 0.123
    end

    it "should format fantasy_improvement" do
      player.fantasy_improvement = 12
      player.fantasy_improvement.should == 12
    end
  end
end