require "orkut/config"

module Orkut

  class Client

    require "orkut/client/profile"   

    include Orkut::Client::Profile
   
    attr_accessor *Config::VALID_OPTIONS_KEYS
   
    # Initializes a new API object
    #
    # @return [Orkut::Client]
    def initialize(attrs={})
      attrs = Orkut.options.merge(attrs)
      Config::VALID_OPTIONS_KEYS.each do |key|
        instance_variable_set("@#{key}".to_sym, attrs[key])
      end   
    end 
   
  end
  
end