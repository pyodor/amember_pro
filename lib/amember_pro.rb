require 'json'
require 'faraday'
require 'dish'
require "amember_pro/version"
require "amember_pro/users"
require "amember_pro/invoices"
require "amember_pro/products"
require "amember_pro/check_access"
require "amember_pro/parameters"
require "amember_pro/response"

module AmemberPro
  END_POINT = 'api'

  class << self
    attr_accessor :url
    attr_accessor :access_key
    attr_accessor :params
    attr_accessor :method
    attr_accessor :model

    def new(url, access_key)
      self.url        = url
      self.access_key = access_key
    end

    def connection(model)
      method      = self.method
      params      = self.params.to_hash
      self.model  = model.to_s
      api         = "/#{self::END_POINT}/#{self.model}"
  
      if method == Method::PUT or method == Method::DELETE
        api += "/#{params[:id]}"
      end

      params[:_key] = self.access_key
      conn          = Faraday.new(:url => self.url, :ssl => {:verify => false})
      
      case method
      when Method::GET
        res = conn.get api, params
      when Method::POST
        res = conn.post api, params
      when Method::PUT
        res = conn.put api, params
      when Method::DELETE
        res = conn.delete api, params
      end
      self::Response.new(res.body)
      #Dish(JSON.parse(res.body))
    end
  end

  module Method
    GET = 'get'
    POST = 'post'
    PUT = 'put'
    DELETE = 'delete'
  end

  module Configurator
    RAILS_CONFIG_DIR = 'config'
    AMEMBER_YAML_NAME = 'amember_pro.yml'
    AMEMBER_YAML_FILE = "#{RAILS_CONFIG_DIR}/#{AMEMBER_YAML_NAME}"
    RAILS_INITIALIZERS_DIR = "#{RAILS_CONFIG_DIR}/initializers"
    AMEMBER_INITIALIZERS_FILE = "#{RAILS_INITIALIZERS_DIR}/amember_pro.rb"

    class << self
      def rails_config_make
        raise 'Rails config directory not found.' unless rails_config_dir_exists?
        raise 'Rails config/initializers directory not found.' unless rails_initializers_dir_exists?
        write_yaml_config_file unless amember_config_file_exists?
        write_initializers_file
      end

      private
      
      def write_initializers_file
        code = <<-CODE
          AMEMBER_PRO = YAML::load_file(Rails.root + '#{AMEMBER_YAML_FILE}');
          AmemberPro.new(AMEMBER_PRO['url'], AMEMBER_PRO['access_key'])
        CODE
        File.open(AMEMBER_INITIALIZERS_FILE, "w+") do |f| 
          code.each_line do |line|
            f.write("#{line.strip!}\n")
          end
        end
      end

      def write_yaml_config_file
        require 'yaml'
        data = {
          "url" => "YOUR AMEMBER URL INSTALLTION HERE",
          "access_key" => "YOUR ACCESS KEY HERE"
        }
        File.open(AMEMBER_YAML_FILE, "w") {|f| f.write(data.to_yaml)}

      end

      def rails_config_dir_exists?
        File.directory?(RAILS_CONFIG_DIR)
      end

      def amember_config_file_exists?
        File.exists?(AMEMBER_YAML_FILE)
      end

      def rails_initializers_dir_exists?
        File.directory?(RAILS_INITIALIZERS_DIR)
      end
    end
  end
end
