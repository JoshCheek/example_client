require 'rest-client'

class Client
  module Internet
    class Response
      attr_accessor :status, :body
      def initialize(status, body)
        self.status = status
        self.body   = body
      end
    end

    class Rack
      # Use like this:
      #   session = Rack::Test::Session.new(Rails.application)
      #   session.basic_authorize 'username', 'password' # <-- if you need basic auth
      #   internet = Internet::Rack.new session
      #   internet.get "/whatever"
      def initialize(session)
        @session = session
      end

      def get(path)
        response = @session.get path
        Response.new response.status, response.body
      end
    end

    class RestClient
      def initialize(base)
        @base = base
      end

      def get(path)
        response = ::RestClient.get @base + path
        Response.new response.code, response.body
      end
    end
  end


  class UserRepository
    def initialize(internet)
      @internet = internet
    end

    def find(user_id)
      result     = @internet.get "/users/#{user_id}.json"
      attributes = JSON.parse result.body
      Client::User.new attributes
    end
  end

  class User
    attr_accessor :id, :name
    def initialize(attributes)
      self.id   = attributes["id"]
      self.name = attributes["name"]
    end
  end
end
