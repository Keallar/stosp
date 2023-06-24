# frozen_string_literal: true

module Stosp
  class Client
    module Import
      def import
        post '/org/purchase/importExport/apiImport'
      end
    end
  end
end
