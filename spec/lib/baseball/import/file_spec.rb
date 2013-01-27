require 'spec_helper'

describe Baseball::Import::File do
  describe 'initialize' do
    let(:file) { Baseball::Import::File.new(:skip_first => true, :file => fixture_path('players.csv')) }

    it 'should parse first line if skip_first is false' do
      file.skip_first = false
      file.read
      file.data.first[0].should == "playerID"
    end

    it 'should honor skip_first argument to remove header line' do
      file.read
      file.data.first[0].should_not == "playerID"
    end
  end
end