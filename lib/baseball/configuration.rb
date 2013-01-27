module Baseball
  class Configuration
    attr_accessor :storage, :player_map, :player_stat_map

    def initialize
      @storage = Baseball::Storage::Memory.new
      @player_map = [:uid, :birth_year, :first_name, :last_name]
      @player_stat_map = [:uid, :year, :team_abbr, :g, :ab, :r, :h, :doubles, :triples, :hr, :rbi, :sb, :cs]
    end
  end
end