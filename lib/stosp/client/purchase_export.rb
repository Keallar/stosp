# frozen_string_literal: true

module Stosp
  class Client
    module PurchaseExport
      def purchase_export
        get '/org/purchase/importExport/apiExport'
      end
    end
  end
end
