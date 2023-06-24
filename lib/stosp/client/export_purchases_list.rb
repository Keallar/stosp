# frozen_string_literal: true

module Stosp
  class Client
    module ExportPurchasesList
      def export_purchases_list
        get '/purchase/apiExportPurchasesList'
      end
    end
  end
end
