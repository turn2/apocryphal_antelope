module CoreExtendors
  module VERSION
    MAJOR = 0
    MINOR = 0
    TINY = 1
  
    class << self
      def pretty
        "#{MAJOR}.#{MINOR}.#{TINY}"
      end
      alias_method :print, :pretty
    end
  end
end
