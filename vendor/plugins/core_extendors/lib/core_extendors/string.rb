module CoreExtendors
  module String
    module Extendors
      def random(length=10)
        length.times.collect { CoreExtendors::ALPHANUM[rand(CoreExtendors::ALPHANUM.size + 1)] }.join
      end
    end
    
    module Includors
      def randomize
        self.split(//).inject("") do |i, char|
          i.insert(rand(i.size + 1), char)
        end
      end
      alias_method :shuffle, :randomize
    
      def randomize!
        self.gsub!(/^.*$/, self.randomize)
      end
      alias_method :shuffle!, :randomize!
    end
  end
end
