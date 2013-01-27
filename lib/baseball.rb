require "baseball/version"
require "baseball/configuration"
require "baseball/calculations"
require "baseball/parse_data"
require "baseball/base"
require "baseball/player"
require "baseball/stat"
require "baseball/storage/memory"
require "baseball/import/file"

module Baseball
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Baseball::Configuration.new
    yield(configuration) if block_given?
  end

  def self.format_float(data)
    sprintf("%.3f", data).to_f
  end

  def self.format_percent(data)
    sprintf("%.1f", data.to_f*100) + "%"
  end
end
