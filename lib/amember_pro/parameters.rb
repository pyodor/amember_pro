module AmemberPro
  module Parameters
    class << self
      attr_accessor :parameters
      attr_accessor :key
      attr_accessor :val
      attr_accessor :args
      attr_accessor :block

      def method_missing method, *args, &block
        self.args = args
        self.key = method.to_s
        self.val = self.args[0]
        self.block = block

        case method
        when :format
          underscore_prefix
          self.val ||= 'json'
        when :count
          underscore_prefix
          self.val ||= '20'
        when :page
          underscore_prefix
          self.val ||= '0'
        when :filter
          underscore_prefix
          filterify
        when :nested
          underscore_prefix
          nestify
        end
        
        add self.key.to_s, self.val.to_s
      end

      def underscore_prefix
        self.key = self.key.insert(0, '_')
      end

      def new
        self.parameters = Hash.new
        self
      end

      def add key, value
        self.parameters[key.to_s] = value.to_s
        self.parameters
      end

      def to_hash
        self.to_s
      end

      def to_s
        current_params
      end

      private

      def nestify
        puts self.args.inspect
        puts self.block.inspect
      end

      def filterify
        fieldname = self.args[0]
        self.key = "#{self.key}[#{fieldname}]"
        self.val = args[1]
      end

      def current_params
        self.parameters
      end
    end

  end
end
