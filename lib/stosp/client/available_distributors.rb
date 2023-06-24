# frozen_string_literal: true

module Stosp
  class Client
    module AvailableDistributors
      def available_distributors
        get '/express/apiAvailableDistributors'
      end
    end
  end
end
