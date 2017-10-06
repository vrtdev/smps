
class SmPs
  # SmPs Parameter management
  class Parameter
    def initialize(options)
      @ssm = options[:ssm]
      @name = options[:name]
      @type = options[:type]
      @key_id = options[:key_id]
      parameter
    end

    def parameter(decrypt = true)
      resp = @ssm.get_parameter(
        name: @name,
        with_decryption: decrypt
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

    def exists?
      @exists
    end

    def write!(value, description = nil)
      return true if value == @value
      @ssm.put_parameter(
        name: @name, value: value,
        description: description, type: @type,
        key_id: @key_id, overwrite: @exists,
        # allowed_pattern: "AllowedPattern",
      )
      @value = value
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
