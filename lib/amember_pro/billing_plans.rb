module AmemberPro
  class BillingPlans
    def self.get(params={})
      connection(Method::GET, params).body
    end

    def self.to_s
      'billing-plans'
    end

    private

    def self.connection(method, params={})
      AmemberPro.params = params
      AmemberPro.method = method
      AmemberPro.connection(self)
    end
  end
end
