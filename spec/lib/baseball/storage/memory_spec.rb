require 'spec_helper'

describe Baseball::Storage::Memory do
  describe "initialize" do
    let(:storage) { Baseball::Storage::Memory.new }

    it 'should initialize player storage' do
      storage.players.should be_instance_of(Array)
    end
  end

  describe "finders" do
    let(:storage) { Baseball::Storage::Memory.new }
    let(:player1) { Baseball::Player.new(:uid => "player1", :first_name => "Fredrik")}
    let(:player2) { Baseball::Player.new(:uid => "player2", :first_name => "Bob")}

    before do
      storage.players << player1 << player2
    end

    it 'should store players' do
      storage.players.size.should == 2
    end

    describe "#find_by_key" do
      it 'should find by uid' do
        storage.find_all_by_uid("player1").should == [player1]
      end

      it 'should find by first_name' do
        storage.find_all_by_first_name("Bob").should == [player2]
      end
    end
  end

  describe "#empty!" do
    let(:storage) { Baseball::Storage::Memory.new }
    let(:player1) { Baseball::Player.new(:uid => "player1", :first_name => "Fredrik")}
    let(:player2) { Baseball::Player.new(:uid => "player2", :first_name => "Bob")}

    before do
      storage.players << player1 << player2
    end

    it 'should empty the storage' do
      storage.empty!
      storage.players.should be_empty
    end
  end
end