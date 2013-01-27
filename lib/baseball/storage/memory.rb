module Baseball
  module Storage
    class Memory
      attr_reader :players

      def initialize
        empty!
      end

      def method_missing(meth, *args, &block)
        if meth.to_s =~ /^find_all_by_(.+)$/
          @players.select {|u| u.send($1) == args.first}
        else
          super
        end
      end

      def empty!
        @players = Array.new
      end
    end
  end
end