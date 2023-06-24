# frozen_string_literal: true

module Stosp
  class Client
    module Create
      def create(options)
        post '/express/apiCreate', options
      end
    end
  end
end
