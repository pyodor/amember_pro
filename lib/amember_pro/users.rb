module AmemberPro
  class Users
    
    attr_accessor :id

    def self.get(params={})
      connection('get', params).body
    end

    def self.add(params)
      connection('post', params).body
    end
    
    def self.update(params={})
      raise ArgumentError, 'user id is required' unless id
      self.connection('put', params).put.body
    end
    
    def self.delete(id)
      raise ArgumentError, 'user id is required' unless id
      self.connection('delete', id).delete.body
    end

    def self.to_string
      'users?'
    end

    private
    
    def self.connection(method, params={})
      params[:_key] = AmemberPro.access_key
      url = AmemberPro.url
      api = "/#{AmemberPro::END_POINT}/users"
      conn = Faraday.new(:url => url, :ssl => {:verify => false})
      
      case method
      when 'get'
        # TODO
      when 'post'
        conn.post api, params
      end

      #url = self.url
      #url.sub!(self.to_string, "users/#{id}?") unless id.nil?
      #Faraday.new(:url => url, :ssl => {:verify => false})
    end

    def self.url
      AmemberPro.build_url self
    end
  end
end
