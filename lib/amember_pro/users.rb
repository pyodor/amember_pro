module AmemberPro
  class Users

    attr_accessor :id

    def self.get(params={})
      connection('get', params).body
    end

    def self.add(params)
      connection('post', params).body
    end

    def self.update(id, params={})
      params[:id] = id
      self.connection('put', params).body
    end

    def self.delete(id)
      params = {:id => id}
      self.connection('delete', params).body
    end

    def self.to_string
      'users?'
    end

    private

    def self.connection(method, params={})
      api = "/#{AmemberPro::END_POINT}/users"
      if method == 'put' or method == 'delete'
        api += "/#{params[:id]}"
      end

      params[:_key] = AmemberPro.access_key
      url = AmemberPro.url
      conn = Faraday.new(:url => url, :ssl => {:verify => false})

      case method
      when 'get'
        conn.get api, params
      when 'post'
        conn.post api, params
      when 'put'
        conn.put api, params
      when 'delete'
        conn.delete api, params
      end
    end

    def self.url
      AmemberPro.build_url self
    end
  end
end
