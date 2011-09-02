module Auth
  module Base
    def self.included(base)
      base.send(:include, InstanceMethods)
      base.extend ClassMethods

      base.class_eval do
        before_filter :authenticate, :require_manager
      end
    end

    module ClassMethods
      def allow_public(*actions)
        skip_before_filter :authenticate, :require_manager, :only => actions
      end

      def allow_wholesaler(*actions)
        skip_before_filter :require_manager, :only => actions
      end
    end

    module InstanceMethods
      def require_manager
        deny_access unless current_user.has_role?("manager")
      end
    end
  end
end
