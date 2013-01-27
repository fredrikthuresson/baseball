module Baseball
  class Base
    include Baseball::Calculations
    include Baseball::ParseData

    attr_accessor :configuration

    def initialize
      Baseball.configure
      @configuration = Baseball.configuration
    end

    def storage
      configuration.storage
    end

    def players
      storage.players
    end

  end
end