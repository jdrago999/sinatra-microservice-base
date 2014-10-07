
module ApiClient
  class Wrapper
    require 'rest_client'
    require 'uri'

    def self.create_user(params)
      url = URI(ApiClient.base_url)
      url.path = '/users'
      RestClient.log = $stderr
      RestClient.post(url.to_s, params)
    end


    private

  end
end
