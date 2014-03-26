module AmemberPro
  class Users

    def self.get(params={})
      connection(Method::GET, params).body
    end

    def self.add(params)
      connection(Method::POST, params).body
    end

    def self.update(id, params={})
      params[:id] = id
      self.connection(Method::PUT, params).body
    end

    def self.delete(id)
      params = {:id => id}
      self.connection(Method::DELETE, params).body
    end

    def self.to_s
      'users'
    end

    private

    def self.connection(method, params={})
      AmemberPro.params = params
      AmemberPro.method = method
      AmemberPro.connection(self)
    end
  end
end
