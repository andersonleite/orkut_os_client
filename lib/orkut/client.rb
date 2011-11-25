require "orkut/config"
require "orkut/rpc"

module Orkut

  class Client

    require "orkut/client/profile"   
    require "orkut/client/friends"
    require "orkut/client/scraps"

    include Orkut::Client::Profile
    include Orkut::Client::Friends
    include Orkut::Client::Scraps
   
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