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
    
    def self.to_s
      'check-access'
    end

    private
    
    def self.check_access(amember_method, params)
      connection(Method::GET, amember_method, params).body
    end

    def self.connection(method, amember_method, params={})
      api = "#{AmemberPro::END_POINT}/#{self.to_s}/#{amember_method}"

      params[:_key] = AmemberPro.access_key
      url = AmemberPro.url
      conn = Faraday.new(:url => url, :ssl => {:verify => false})

      case method
      when 'get'
        conn.get api, params
      end
    end
  end
end
