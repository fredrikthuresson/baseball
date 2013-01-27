module Baseball
  class Player
    attr_reader :birth_year, :uid, :first_name, :last_name, :stats
    attr_writer :batting_improvement, :slugging_percentage
    attr_accessor :fantasy_improvement

    def initialize(options={})
      @uid        = options.delete(:uid)
      @birth_year = options.delete(:birth_year)
      @first_name = options.delete(:first_name)
      @last_name  = options.delete(:last_name)
      @stats      = Array.new

      class << @stats
        def <<(stat)
          raise ArgumentError, "Player#stats only accepts objects of type Baseball::Stat" unless stat.class == Baseball::Stat
          super
        end
      end
    end

    def name
      "#{@first_name} #{@last_name}"
    end

    def batting_improvement
      format_float(@batting_improvement)
    end

    def slugging_percentage
      format_float(@slugging_percentage)
    end

    def format_float(data)
      sprintf("%.3f", data).to_f
    end
  end
end