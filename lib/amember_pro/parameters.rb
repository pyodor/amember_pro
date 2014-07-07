module AmemberPro
  module Parameters
    class << self
      def method_missing meth, *args, &block
        key = meth.to_s
        val = args[0]
        case key
        when 'format'
          key.insert(0, '_')
          val ||= 'json'
        when 'count'
          key.insert(0, '_')
          val ||= '20'
        when 'page'
          key.insert(0, '_')
          val ||= '0'
        end
        add key.to_s, val.to_s
      end

      def new
        @@parameters = Hash.new
        self
      end

      def add key, value
        @@parameters[key.to_s] = value.to_s
        @@parameters
      end

      def to_s
        current_params
      end

      private

      def current_params
        @@parameters
      end
    end

  end
end
