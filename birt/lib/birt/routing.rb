module Birt #:nodoc:
  module Routing #:nodoc:
    module MapperExtensions
      def self.birts
        @set.add_route("/birt/api", {:controller => "birt/api_controller", :action => "index"})
      end
    end
  end
end
