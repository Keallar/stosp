# frozen_string_literal: true

require 'logger'

module Stosp
  class Logger < ::Logger
    def self.logger
      @logger ||= begin
        logger = new $stdout
        logger
      end
    end

    def self.log_response(response, show_body: true)
      verb = response.request.http_method.to_s.split('::').last.upcase
      request_body = response.request.raw_body if verb != 'GET' && show_body
      uri = response.uri
      parsed_response = response.parsed_response
      result = parsed_response['result'] || parsed_response
      error = parsed_response['errors']&.first
      error ||= parsed_response['error']
      if (error.nil? || error.empty?) && parsed_response['data'] &&
         parsed_response['data'].is_a?(Array) && parsed_response['data'].first&.key?('errors')
        error ||= parsed_response['data'].first['errors']
      end
      response_body = parsed_response unless result

      logger.info "#{verb} #{uri}#{request_body} -> result: #{result} #{uri}#{response_body}"
      return if response.fetch('result', true) && (error.nil? || error.empty?)

      raise HTTParty::Error, "#{error} #{uri}#{response_body} <- #{verb} #{uri}#{request_body}"
    end
  end
end
