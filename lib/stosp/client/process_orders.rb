# frozen_string_literal: true

module Stosp
  class Client
    module ProcessOrders
      def process_orders(pid, options = {})
        get '/org/purchase/processOrders/api', options.merge(pid: pid)
      end
    end
  end
end
