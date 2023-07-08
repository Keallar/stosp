# frozen_string_literal: true

module Stosp
  class Client
    module Import
      def import(options)
        post '/org/purchase/importExport/apiImport', options
      end
    end
  end
end
