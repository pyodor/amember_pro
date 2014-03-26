require 'faraday'
require "amember_pro/version"
require "amember_pro/users"
require "amember_pro/invoices"
require "amember_pro/products"
require "amember_pro/check_access"

module AmemberPro
  END_POINT = 'api'

  class << self
    attr_accessor :url
    attr_accessor :access_key
    attr_accessor :params
    attr_accessor :method

    def new(url, access_key)
      self.url = url
      self.access_key = access_key
    end

    def connection(controller)
      method = self.method
      params = self.params
      api = "/#{self::END_POINT}/#{controller.to_s}"

      if method == Method::PUT or method == Method::DELETE
        api += "/#{params[:id]}"
      end

      params[:_key] = self.access_key
      conn = Faraday.new(:url => self.url, :ssl => {:verify => false})

      case method
      when Method::GET
        conn.get api, params
      when Method::POST
        conn.post api, params
      when Method::PUT
        conn.put api, params
      when Method::DELETE
        conn.delete api, params
      end
    end
  end

  module Method
    GET = 'get'
    POST = 'post'
    PUT = 'put'
    DELETE = 'delete'
  end
end
