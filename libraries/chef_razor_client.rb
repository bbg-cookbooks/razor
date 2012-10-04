require 'rest_client'

class Chef
  module Razor
    class Client

      def initialize(host = "127.0.0.1", port = 8026)
        @host, @port = host, port
      end

      def get(resource)
        response = RestClient.get(url_for(resource), :accept => :json)
        JSON.parse(response)
      end

      private

      def url_for(path)
        "http://#{@host}:#{@port}/razor/api/#{path}"
      end
    end
  end
end
