require 'spec_helper'

describe Baseball::Configuration do
  let(:configuration) { Baseball::Configuration.new }

  it 'should assign storage by default' do
    configuration.storage.should be_instance_of(Baseball::Storage::Memory)
  end

  it 'should allow overriding of default storage' do
    configuration.storage = "SomeStorage"
    configuration.storage.should == "SomeStorage"
  end

  it 'should set player map by default' do
    configuration.player_map.should == [:uid, :birth_year, :first_name, :last_name]
  end

    it 'should allow overriding of default player_map' do
    configuration.player_map = [:uid, :name]
    configuration.player_map.should == [:uid, :name]
  end

  it 'should set player stat map by default' do
    configuration.player_map.should == [:uid, :birth_year, :first_name, :last_name]
  end

    it 'should allow overriding of default player stat map' do
    configuration.player_stat_map = [:uid, :stat]
    configuration.player_stat_map.should == [:uid, :stat]
  end

end