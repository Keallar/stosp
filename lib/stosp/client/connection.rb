# frozen_string_literal: true

module Stosp
  class Client
    module Connection
      def get(path, options = {})
        request :get, path, options
      end

      def post(path, options = {})
        request :post, path, options
      end

      def put(path, options = {})
        request :put, path, options
      end

      def delete(path, options = {})
        request :delete, path, options
      end

      private

      def request(http_method, path, options)
        response = self.class.send(http_method, path, { query: options })
        Logger.log_response(response)
        response.parsed_response
        response.with_indifferent_access
      end
    end
  end
end
