# frozen_string_literal: true

module Stosp
  class Client
    module PurchaseExport
      def purchase_export(options = {})
        get '/org/purchase/importExport/apiExport', options
      end
    end
  end
end
