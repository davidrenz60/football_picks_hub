module NflApi
  module Middleware
    class JsonParsing < Faraday::Middleware
      def initialize(app)
        super(app)
        @app = app
      end

      def call(env)
        @app.call(env).on_complete do |response_env|
          parse_json(response_env)
        end
      end

      def parse_json(env)
        data = JSON.parse(env.body)
        env.body = data
      end
    end
  end
end