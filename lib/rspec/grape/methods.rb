module RSpec
  module Grape
    module Methods
      include Rack::Test::Methods

      def app
        self.described_class
      end

      def api_method
        api_endpoint_description.split(' ').first.downcase.to_sym
      end

      def api_url
        api_endpoint_description.split(' ').last
      end

      def call_api(params = nil)
        params ||= self.respond_to?(:api_params) ? api_params : {}

        self.send(api_method, api_url, params)
      end

      private

      def api_endpoint_description
        @api_endpoint_description ||= RSpec::Grape::Utils.find_endpoint_description(self.class)
      end
    end
  end
end