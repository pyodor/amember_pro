module AmemberPro
  class Products
    def self.get(params={})
      connection(Method::GET, params)
    end

    def self.add(params)
      connection(Method::POST, params)
    end

    def self.update(id, params={})
      params[:id] = id
      self.connection(Method::PUT, params)
    end

    def self.delete(id)
      params = {:id => id}
      self.connection(Method::DELETE, params)
    end

    def self.to_s
      'products'
    end

    private

    def self.connection(method, params={})
      AmemberPro.params = params
      AmemberPro.method = method
      AmemberPro.connection(self)
    end
  end
end
