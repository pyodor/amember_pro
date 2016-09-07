module AmemberPro
  class Access
    def self.get(params={})
      connection(Method::GET, params).body
    end

    def self.to_s
      'access'
    end

    private

    def self.connection(method, params={})
      AmemberPro.params = params
      AmemberPro.method = method
      AmemberPro.connection(self)
    end
  end
end
