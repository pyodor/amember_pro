module AmemberPro
  class CheckAccess
    

    def self.by_login_pass
      connection('by-login-pass').get.body
    end

    def self.by_login
      connection('by-login').get.body
    end
    
    def self.by_email
      connection('by-email').get.body
    end
    
    def self.to_string
      'check-access/'
    end

    private
    
    def self.connection(method)
      url = self.url
      url.sub!(self.to_string, "#{self.to_string}#{method}?")
      Faraday.new(:url => url)
    end

    def self.url
      AmemberPro.build_url self
    end
  end
end
