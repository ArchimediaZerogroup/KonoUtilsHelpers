require 'active_type'
module KonoUtils
  class VirtualModel < ActiveType::Object
    def self.inherited(*)
      ::ActiveSupport::Deprecation.warn 'KonoUtils::VirtualModel is deprecated! Use ActiveType::Object instead.'
      super
    end
  end
end