module AmemberPro
  class CheckAccess
    

    def self.by_login_pass(params={})
      check_access('by-login-pass', params)
    end

    def self.by_login(params={})
      check_access('by-login', params)
    end
    
    def self.by_email(params={})
      check_access('by-email', params)
    end
    
    def self.to_string
      'check-access/'
    end

    private
    
    def self.check_access(amember_method, params)
      connection('get', amember_method, params).body
    end

    def self.connection(method, amember_method, params={})
      api = "/#{AmemberPro::END_POINT}/check-access/#{amember_method}"

      params[:_key] = AmemberPro.access_key
      url = AmemberPro.url
      conn = Faraday.new(:url => url, :ssl => {:verify => false})

      case method
      when 'get'
        conn.get api, params
      end
    end
   
    def self.url
      AmemberPro.build_url self
    end
  end
end
