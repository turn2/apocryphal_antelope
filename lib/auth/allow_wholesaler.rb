module Auth
  module AllowWholesaler
    def self.included(base)
      base.class_eval do
        skip_before_filter :require_manager
      end
    end
  end
end
