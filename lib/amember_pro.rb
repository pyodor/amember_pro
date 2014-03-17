require "amember_pro/version"
require "amember_pro/users"

module AmemberPro
  @@url = nil
  @@access_key = nil
  @@end_point = 'api/'

  def self.init(url, access_key)
    @@url = url + @@end_point
    @@access_key = access_key
  end

  def self.test_if_amember_domain
    puts Users.get
  end

  def self.url
    @@url
  end

  def self.access_key
    @@access_key
  end

  protected

  def self.api_contruction(controller)
    self.url + controller.to_string
  end
end
