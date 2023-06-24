# frozen_string_literal: true

module Stosp
  class Client
    module Calculate
      def calculate(options)
        post '/api/distributor/delivery/calculate', options
      end
    end
  end
end
