module Baseball
  module Calculations

    def top_improved_batting_averages(options={})
      most_improved = []
      limit         = options.delete(:limit)||10
      start_year    = options.delete(:start_year).to_i
      end_year      = options.delete(:end_year).to_i

      players.each do |player|
        start_stat = player.stats.detect {|u| u.year == start_year }
        end_stat = player.stats.detect {|u| u.year == end_year }
        next if start_stat.nil? || end_stat.nil?
        player.batting_improvement = end_stat.batting_average - start_stat.batting_average
        most_improved << player
        most_improved.sort! {|a,b| b.batting_improvement <=> a.batting_improvement }
        most_improved = most_improved.take(limit)
      end
      most_improved
    end

    def slugging_percentage(options={})
      percentages = []
      year = options.delete(:year)
      team = options.delete(:team)
      players.each do |player|
        next unless stat = player.stats.detect {|u| u.team_abbr == team && u.year == year }
        percentages << stat.slugging_percentage if stat.slugging_percentage
      end
      percentages.reduce(:+).to_f/percentages.size
    end

    def top_improved(options={})
      most_improved = []
      limit         = options.delete(:limit)||5
      start_year    = options.delete(:start_year).to_i
      end_year      = options.delete(:end_year).to_i

      players.each do |player|
        start_stat = player.stats.detect {|u| u.year == start_year }
        end_stat = player.stats.detect {|u| u.year == end_year }
        next if start_stat.nil? || end_stat.nil?
        player.fantasy_improvement = end_stat.fantasy_score - start_stat.fantasy_score
        most_improved << player
        most_improved.sort! {|a,b| b.fantasy_improvement <=> a.fantasy_improvement }
        most_improved = most_improved.take(limit)
      end
      most_improved
    end

    def triple_crown(options={})
      year                = options.delete(:year).to_i
      max_batting_average = 0.0
      max_rbi             = 0
      max_hr              = 0

      players.each do |player|
        stat = player.stats.detect {|u| u.year == year }
        next if stat.nil?
        max_batting_average = stat.batting_average if stat.batting_average > max_batting_average
        max_rbi = stat.rbi if stat.rbi > max_rbi
        max_hr  = stat.hr if stat.hr > max_hr
      end

      players.detect do |player|
        stat = player.stats.detect {|u| u.year == year }
        return false if stat.nil?
        stat.batting_average == max_batting_average && stat.rbi == max_rbi && stat.hr == max_hr
      end
    end

  end
end