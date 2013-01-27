require 'spec_helper'

describe Baseball::Base do
  describe ".configure" do

    describe "defaults" do
      let(:base) { Baseball::Base.new }

      it 'should assign Baseball::Storage::Memory as default storage' do
        base.configuration.storage.should be_instance_of(Baseball::Storage::Memory)
      end
    end

    describe 'override' do
      after do
        Baseball.configure do |config|
          config.storage = Baseball::Storage::Memory.new
        end
      end

      it 'should allow a configure block' do
        Baseball.configure do |config|
          config.storage = "TestStorage"
        end
        Baseball::Base.new.configuration.storage.should == "TestStorage"
      end
    end
  end

  describe '#players' do
    let(:base) { Baseball::Base.new }
    let(:player1) { Baseball::Player.new(:uid => "player1", :first_name => "Fredrik")}
    let(:player2) { Baseball::Player.new(:uid => "player2", :first_name => "Bob")}

    before do
      base.storage.empty!
      base.players << player1 << player2
    end

    it 'should store players' do
      base.storage.players.should include(player1)
      base.storage.players.should include(player2)
      base.storage.players.size.should == 2
    end
  end

  describe '#parse_player_data' do
    let(:base) { Baseball::Base.new }
    let(:data) { [["aaron01", "1934", "Aaron", "Jones"], ["frank01", "1945", "Frank", "Spec"], ["jason01", "1945", "Jason", "Spec"]]}

    before do
      base.storage.empty!
      base.parse_player_data(data)
    end

    it 'should build player data and store it' do
      base.players.size.should == data.size
    end

    it 'should build valid players' do
      player = base.storage.find_all_by_uid("aaron01").first
      row = data.first
      player.uid.should        == row[0]
      player.birth_year.should == row[1]
      player.first_name.should == row[2]
      player.last_name.should  == row[3]
    end
  end

  describe '#parse_stat_data' do
    let(:base) { Baseball::Base.new }
    let(:player_data) { [["aaron01", "1934", "Aaron", "Jones"], ["frank01", "1945", "Frank", "Spec"], ["jason01", "1945", "Jason", "Spec"]]}
    let(:player_stats) { [["aaron01", "2008", "NYA", "156", "609", "100", "180", "39", "4", "20", "100", "22", "11"], 
                          ["aaron01", "2009", "FLO", "122", "507", "87", "99", "35", "3", "28", "111", "5", "7"]]}

    before do
      base.storage.empty!
      base.parse_player_data(player_data)
      base.parse_player_stats(player_stats)
      @player = base.storage.find_all_by_uid("aaron01").first
    end

    it 'should build two stats for player' do
      @player.stats.size.should == 2
    end

    it 'should build valid stats' do
      @player.stats.first.year.should == player_stats.first[1].to_i
      @player.stats.last.year.should == player_stats.last[1].to_i
    end
  end

  describe '#top_improved_batting_averages' do
    let(:base) { Baseball::Base.new }
    let(:player_data) { [["aaron01", "1934", "Aaron", "Jones"], ["frank01", "1945", "Frank", "Spec"], ["jason01", "1945", "Jason", "Spec"]]}
    let(:player_stats) { [["aaron01", "2008", "NYA", "156", "100", "100", "50", "39", "4", "20", "100", "22", "11"],
                          ["aaron01", "2009", "NYA", "122", "1000", "87", "600", "35", "3", "28", "111", "5", "7"],
                          ["frank01", "2008", "FLO", "122", "100", "87", "40", "35", "3", "28", "111", "5", "7"],
                          ["frank01", "2009", "FLO", "122", "1000", "87", "600", "35", "3", "28", "111", "5", "7"]]}


    before do
      base.storage.empty!
      base.parse_player_data(player_data)
      base.parse_player_stats(player_stats)
      @players = base.top_improved_batting_averages(:start_year => 2008, :end_year => 2009, :limit => 1)
    end

    it 'should return most improved in order' do
      frank = base.storage.find_all_by_uid("frank01").first
      @players.should == [frank]
    end
  end

  describe '#slugging percentage' do
    let(:base) { Baseball::Base.new }
    let(:player_data) { [["aaron01", "1934", "Aaron", "Jones"],
                        ["aaron02", "1945", "Aaron", "Spelling"],
                        ["aaron03", "1947", "Aaron", "Hunter"],
                        ["frank01", "1948", "Frank", "Spec"],
                        ["jason01", "1945", "Jason", "Spec"]]}
    let(:player_stats) { [["aaron01", "2007", "NYA", "156", "100", "100", "50", "39", "4", "20", "100", "22", "11"],
                          ["aaron02", "2008", "NYA", "122", "1000", "87", "600", "35", "3", "28", "111", "5", "7"],
                          ["aaron03", "2007", "NYA", "122", "100", "87", "40", "35", "3", "28", "111", "5", "7"],
                          ["frank01", "2007", "FLO", "122", "1000", "87", "600", "35", "3", "28", "111", "5", "7"],
                          ["jason01", "2007", "NYA", "", "", "", "", "", "", "", "", "", ""]]}


    before do
      base.storage.empty!
      base.parse_player_data(player_data)
      base.parse_player_stats(player_stats)
      @percentage = base.slugging_percentage(:team => "NYA", :year => 2007)
    end

    it 'should calculate the teams slugging average for the year' do
      sprintf("%.2f", @percentage).to_f.should == 1.61
    end

  end

  describe '#top_improved_players' do
    let(:base) { Baseball::Base.new }
    let(:player_data) { [["aaron01", "1934", "Aaron", "Jones"], ["frank01", "1945", "Frank", "Spec"], ["jason01", "1945", "Jason", "Spec"]]}
    let(:player_stats) { [["aaron01", "2011", "NYA", "156", "100", "100", "50", "39", "4", "1", "100", "22", "11"],
                          ["aaron01", "2012", "NYA", "122", "1000", "87", "600", "35", "3", "2", "111", "5", "7"],
                          ["frank01", "2011", "FLO", "122", "100", "87", "40", "35", "3", "1", "111", "5", "7"],
                          ["frank01", "2012", "FLO", "122", "1000", "87", "600", "35", "3", "100", "111", "5", "7"]]}


    before do
      base.storage.empty!
      base.parse_player_data(player_data)
      base.parse_player_stats(player_stats)
      @improved = base.top_improved(:start_year => 2011, :end_year => 2012, :limit => 1)
    end

    it 'should return most improved in order' do
      frank = base.storage.find_all_by_uid("frank01").first
      @improved.should == [frank]
    end
  end

  describe '#triple_crown' do
    let(:base) { Baseball::Base.new }
    let(:player_data) { [["aaron01", "1934", "Aaron", "Jones"], ["frank01", "1945", "Frank", "Spec"], ["jason01", "1945", "Jason", "Spec"]]}
    let(:player_stats) { [["aaron01", "2011", "NYA", "100", "101", "100", "50", "39", "4", "10", "50", "22", "11"],
                          ["aaron01", "2012", "NYA", "122", "1000", "87", "600", "35", "3", "2", "115", "5", "7"],
                          ["frank01", "2011", "FLO", "100", "101", "50", "40", "35", "3", "8", "49", "5", "7"],
                          ["frank01", "2012", "FLO", "122", "1000", "87", "600", "35", "3", "12", "111", "5", "7"]]}


    before do
      base.storage.empty!
      base.parse_player_data(player_data)
      base.parse_player_stats(player_stats)
    end

    it 'should return the triple crown winner' do
      aaron = base.storage.find_all_by_uid("aaron01").first
      triple_crown = base.triple_crown(:year => 2011)
      triple_crown.should == aaron
    end

    it 'should return false when no triple crown winner' do
      triple_crown = base.triple_crown(:year => 2012)
      triple_crown.should == false
    end
  end
end