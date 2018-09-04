
# frozen_string_literal: true

module SmPs
  # SmPs Parameter management
  class Parameter
    attr_accessor :name, :type, :key_id, :decrypt, :description

    def initialize(options)
      @ssm = options[:ssm]
      @name = options[:name]
      @value = options[:value]
      @type = options[:type]
      @key_id = options[:key_id]
      @decrypt = options[:decrypt] || true
      fetch = options[:fetch]
      fetch = true if options[:fetch].nil?
      parameter if fetch
    end

    def parameter
      resp = @ssm.get_parameter(
        name: @name, with_decryption: @decrypt
      )
      @type = resp.parameter.type
      @value = resp.parameter.value
      @exists = true
    rescue Aws::SSM::Errors::ParameterNotFound
      @exists = false
    end

    def to_s
      @value
    end

    def value
      return @value.split(',') if @type == 'StringList'
      @value
    end

    def value=(value)
      @changed = true if value != @value
      @value = value
    end

    def exists?
      @exists
    end

    def write!(value = nil)
      @changed = true if value != @value
      @value = value if value
      @ssm.put_parameter(
        name: @name, value: @value, type: @type,
        description: @description, key_id: @key_id, overwrite: @exists,
        # allowed_pattern: "AllowedPattern",
      )
      @value
    end

    def history
      # get_parameter_history
    end

    def tag
      # add_tags_to_resource
      # remove_tags_from_resource
    end
  end
end
