
module MyService
  class Client
    require 'rest_client'
    require 'uri'

    def self.create_user(params)
      url = URI(MyService.base_url)
      url.path = '/users'
      if ENV['DEBUG']
        RestClient.log = $stderr
      end
      RestClient.post(url.to_s, params)
    end

  end
end
