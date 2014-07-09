module AmemberPro
  class Response
    attr_accessor :response

    def initialize response
      self.response = JSON.parse(response)
      normalize
      true
    end

    def to_dish
      Dish(self.response)
    end

    def to_s
      self.response.to_s
    end

    private

    def normalize
      items = []
      total = self.response["_total"]
      if(total)
        total = total.to_i
        total.times do |n|
          p n.to_s
          items << self.response.delete(n.to_s)
        end
        puts items.count
        puts items[0].inspect
        puts AmemberPro.model
        puts self.response.inspect
        self.response[AmemberPro.model] = items
      end
    end
  end
end
