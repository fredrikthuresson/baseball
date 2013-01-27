module Baseball
  class Stat

    attr_reader :uid, :year, :team_abbr, :g, :ab, :r, :h, :doubles, :triples, :hr, :rbi, :sb, :cs

    def initialize(options={})
      @uid        = options.delete(:uid)
      @year       = options.delete(:year).to_i
      @team_abbr  = options.delete(:team_abbr)
      @g          = options.delete(:g).to_i
      @ab         = options.delete(:ab).to_i
      @r          = options.delete(:r).to_i
      @h          = options.delete(:h).to_i
      @doubles    = options.delete(:doubles).to_i
      @triples    = options.delete(:triples).to_i
      @hr         = options.delete(:hr).to_i
      @rbi        = options.delete(:rbi).to_i
      @sb         = options.delete(:sb).to_i
      @cs         = options.delete(:cs).to_i
    end

    def batting_average
      @h.to_f/@ab
    end

    def slugging_percentage
      return false unless @h > 0 && @doubles > 0 && @triples > 0 && @hr > 0 && @ab > 0
      ((@h - @doubles - @triples - @hr) + (2*@doubles) + (3*@triples) + (4*@hr)).to_f/@ab
    end

    def fantasy_score
      @hr*4 + @rbi + @sb + @cs
    end
  end
end