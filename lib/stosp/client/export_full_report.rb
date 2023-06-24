# frozen_string_literal: true

module Stosp
  class Client
    module ExportFullReport
      def export_full_report
        get '/org/default/apiExportFullReport'
      end
    end
  end
end
