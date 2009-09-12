require 'rack'

module Imagetastic
  class Parameters

    attr_accessor :uid, :processing_method, :mime_type
    attr_writer :options, :encoding

    def initialize(attributes={})
      %w(uid processing_method options mime_type encoding).each do |attribute|
        instance_variable_set("@#{attribute}", attributes[attribute.to_sym])
      end
    end

    def options
      @options ||= {}
    end
    
    def encoding
      @encoding ||= {}
    end
    
    def [](attribute)
      send(attribute)
    end
    
    def []=(attribute, value)
      send("#{attribute}=", value)
    end
    
    def ==(other_parameters)
      self.to_hash == other_parameters.to_hash
    end
    
    def generate_sha(salt, sha_length)
      Digest::SHA1.hexdigest("#{to_sorted_array}#{salt}")[0...sha_length]
    end

    def to_hash
      {
        :uid => uid,
        :processing_method => processing_method,
        :options => options,
        :mime_type => mime_type,
        :encoding => encoding
      }
    end

    private
    
    def to_sorted_array
      to_hash.sort{|a,b| a[1].to_s <=> b[1].to_s }
    end

  end
end