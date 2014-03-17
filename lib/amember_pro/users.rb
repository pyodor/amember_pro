require 'faraday'

module AmemberPro
  class Users
    @@users = 'users?'

    def self.get
      self.url
    end

    def self.to_string
      @@users
    end

    def self.url
      AmemberPro.api_contruction self
    end
  end
end
