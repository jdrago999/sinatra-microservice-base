
module ApiClient
  def self.base_url=(url)
    @@base_url = url
  end
  def self.base_url
    @@base_url
  end
end
