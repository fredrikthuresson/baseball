module Baseball
  module ParseData
    def parse_player_data(data)
      data.each do |player|
        opts = Hash[@configuration.player_map.zip player]
        storage.players << Baseball::Player.new(opts)
      end
    end

    def parse_player_stats(data)
      data.each do |stat|
        player = storage.find_all_by_uid(stat[0]).first
        opts = Hash[@configuration.player_stat_map.zip stat]
        player.stats << Baseball::Stat.new(opts)
      end
    end
  end
end