
module MyService
require 'ostruct'
  class Client
    require 'rest_client'
    require 'uri'

    def self.create_foobar(params)
      url = URI(MyService.base_url)
      url.path = '/foobars'
      if ENV['DEBUG']
        RestClient.log = $stderr
      end
      begin
        result = RestClient.post(url.to_s, params)
        data = JSON.parse(result, symbolize_names: true)
        data[:foobar]
      rescue RestClient::Exception => e
        raise "Failed to create user"
      end
    end

  end
end
