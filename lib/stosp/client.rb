# frozen_string_literal: true

require 'stosp/client/connection'
require 'stosp/client/available_distributors'
require 'stosp/client/calculate'
require 'stosp/client/check_orders'
require 'stosp/client/create'
require 'stosp/client/export_full_report'
require 'stosp/client/export_purchases_list'
require 'stosp/client/import'
require 'stosp/client/process_orders'
require 'stosp/client/purchase_export'
require 'stosp/client/purchase_export_meta'
require 'stosp/client/sticker_print'

module Stosp
  class Client
    include HTTParty
    include Client::Connection
    include Client::AvailableDistributors
    include Client::Calculate
    include Client::CheckOrders
    include Client::Create
    include Client::ExportFullReport
    include Client::ExportPurchasesList
    include Client::Import
    include Client::ProcessOrders
    include Client::PurchaseExport
    include Client::PurchaseExportMeta
    include Client::StickerPrint

    def initialize(access_token:)
      @access_token ||= access_token
      self.class.base_uri 'https://www.100sp.ru'
      self.class.headers 'x-api-key' => @access_token
    end
  end
end
