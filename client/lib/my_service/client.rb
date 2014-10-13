
module MyService
require 'ostruct'
  class Client
    require 'rest_client'
    require 'uri'

    def self.create_user(params)
      url = URI(MyService.base_url)
      url.path = '/users'
      if ENV['DEBUG']
        RestClient.log = $stderr
      end
      begin
        result = RestClient.post(url.to_s, params)
        data = JSON.parse(result, symbolize_names: true)
        data[:user]
      rescue RestClient::Exception => e
        raise "Failed to create user"
      end
    end

  end
end
