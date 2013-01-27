require 'spec_helper'

describe Baseball::Stat do
  describe "initialize" do
    let(:opts) { {:uid => "frank001", :year => "2012", :team_abbr => "NYA", :g => "156", :ab => "609", :r => "100", :h => "180", 
                    :doubles => "39", :triples => "4", :hr => "20", :rbi => "105", :sb => "22", :cs => "11"} }
    let(:stat) { Baseball::Stat.new(opts) }

    it 'should set uid' do
      stat.uid.should == "frank001"
    end

    it 'should set the year' do
      stat.year.should == 2012
    end

    it 'should set the team abbreviation' do
      stat.team_abbr.should == "NYA"
    end

    it 'should set the g?' do
      stat.g.should == 156
    end

    it 'should set the at-bats' do
      stat.ab.should == 609
    end

    it 'should set the r' do
      stat.r.should == 100
    end

    it 'should set the hits' do
      stat.h.should == 180
    end

    it 'should set the doubles' do
      stat.doubles.should == 39
    end

    it 'should set the triples' do
      stat.triples.should == 4
    end

    it 'should set the home runs' do
      stat.hr.should == 20
    end

    it 'should set the runs batted in' do
      stat.rbi.should == 105
    end

    it 'should set the stolen bases' do
      stat.sb.should == 22
    end

    it 'should set the caught stealing' do
      stat.cs.should == 11
    end

    it 'should calculate batting average' do
      stat.batting_average.should == stat.h.to_f/stat.ab
    end

    it 'should calculate slugging percentage' do
      stat.slugging_percentage.should == ((stat.h - stat.doubles - stat.triples - stat.hr) + (2*stat.doubles) + (3*stat.triples) + (4*stat.hr)).to_f/stat.ab
    end

    it 'should calculate fantasy score' do
      stat.fantasy_score.should == stat.hr*4 + stat.rbi + stat.sb + stat.cs
    end
  end
end