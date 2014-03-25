module AmemberPro
  class Products
    
    attr_accessor :id

    def self.get
      connection.get.body
    end

    def self.add
      connection.post.body
    end
    
    def self.update(id=nil)
      raise ArgumentError, 'user id is required' unless id
      self.connection(id).put.body
    end
    
    def self.delete(id=nil)
      raise ArgumentError, 'user id is required' unless id
      self.connection(id).delete.body
    end

    def self.to_string
      'products?'
    end

    private
    
    def self.connection(id=nil)
      url = self.url
      url.sub!(self.to_string, "products/#{id}?") unless id.nil?
      Faraday.new(:url => url, :ssl => {:verify => false})
    end

    def self.url
      AmemberPro.build_url self
    end
  end
end
