# frozen_string_literal: true

module Stosp
  class Client
    module PurchaseExportMeta
      def purchase_export_meta(purchase)
        get '/purchase/apiExportMeta', purchase: purchase
      end
    end
  end
end
