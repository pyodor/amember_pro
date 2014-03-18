require "amember_pro/version"
require "amember_pro/users"

module AmemberPro
  END_POINT = 'api/'

  class << self
    attr_accessor :url
    attr_accessor :access_key
    attr_accessor :params
  
    def new(url, access_key, options=nil)
      self.url = url + END_POINT
      self.access_key = access_key
      self.add_params(options) if options
    end

    def test_if_amember_domain
      puts Users.get
    end

    protected

    def api_contruction(controller)
      self.url + controller.to_string + Parameter::KEY + self.access_key + self.params
    end

    def add_params(options)
      self.params = ''
      options[:params].each do |key, value|
        if Parameter::ALLOWED.keys.include?(key)
          self.params += "#{Parameter::ALLOWED[key]}#{value}"
        end
      end if options[:params]
    end
  end

  module Parameter
    KEY = '_key='
    ALLOWED = {
      :format => '&_format=',
      :count => '&_count=',
      :page => '&_page=',
      :filter => '&_filter=',
      :nested => '&_nested='
    }
  end
end
