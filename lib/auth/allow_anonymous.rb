module Auth
  module AllowAnonymous
    def self.included(base)
      base.class_eval do
        skip_before_filter :authenticate
        skip_before_filter :require_manager
      end
    end
  end
end
