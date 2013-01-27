require 'csv'

module Baseball
  module Import
    class File
      attr_reader :data
      attr_writer :skip_first

      def initialize(options={})
        @skip_first = options.delete(:skip_first)||false
        @file       = options.delete(:file)
        @data       = Array.new
      end

      def read
        CSV.foreach(@file) { |row| @data << parse(row) }
        @data.shift if @skip_first
      end

      def parse(row)
        return row
        {:uid => row[0], :birth_year => row[1], :first_name => row[2], :last_name => row[3]}
      end
    end
  end
end