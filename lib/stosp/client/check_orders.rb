# frozen_string_literal: true

module Stosp
  class Client
    module CheckOrders
      def check_orders(mega_order_id, orders = [])
        post '/org/formation/apiCheckOrders',
             {
               megaorderId: mega_order_id,
               orders: orders
             }
      end
    end
  end
end
