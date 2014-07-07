module AmemberPro
  class Parameters
    attr_accessor :parameters
    attr_accessor :key
    attr_accessor :value
    attr_accessor :args
    attr_accessor :block

    def method_missing method, *args, &block
      self.args = args
      self.key = method.to_s
      self.value = self.args[0]
      self.block = block

      case method
      when :format
        underscore_prefix
        self.value ||= 'json'
      when :count
        underscore_prefix
        self.value ||= '20'
      when :page
        underscore_prefix
        self.value ||= '0'
      when :filter
        underscore_prefix
        filterify
      end
      add self.key.to_s, self.value.to_s
    end

    def nested nest
      unless nest.is_a? AmemberPro::Parameters::Nested
        raise "Nest must be of type AmemberPro::Parameters::Nested"
      end
      self.parameters.merge!(nest.to_hash)
    end

    def underscore_prefix
      self.key = self.key.insert(0, '_')
    end

    def initialize &block
      self.parameters = Hash.new
      self.instance_eval(&block) if block_given?
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

    def filterify
      fieldname = self.args[0]
      self.key = "#{self.key}[#{fieldname}]"
      self.value = args[1]
    end

    def current_params
      self.parameters
    end

    
    class Nested
      attr_accessor :nest
      attr_accessor :args
      attr_accessor :nested

      def initialize nest, &block
        self.nest = nest.to_s
        self.args = []
        self.instance_eval(&block) if block_given?
        nestify
      end

      def << params
        unless params.is_a? AmemberPro::Parameters
          raise "params must be of type AmemberPro::Parameters"
        end
        self.args << params.to_hash
      end

      def to_hash
        self.to_s
      end

      def to_s
        self.nested
      end

      def nestify
        self.nested = Hash.new
        self.args.each_with_index do |arg, index|
          k = "_nested[#{self.nest}][#{index}]"
          p arg.inspect
          arg.each do |key,val|
            k += "[#{key}]"
            self.nested[k] = val
          end
        end
      end
    end
  end
end
