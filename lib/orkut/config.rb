require "orkut/version"

module Orkut
  module Config

    # The endpoint that will be used to connect if none is set
    DEFAULT_RPC_ENDPOINT = 'http://sandbox.orkut.com/social/rpc'
    
    # An array of valid keys in the options hash when configuring a {Orkut::Client}
    VALID_OPTIONS_KEYS = [
      :consumer_key,
      :consumer_secret,
      :oauth_token,
      :oauth_token_secret,
    ]

    attr_accessor *VALID_OPTIONS_KEYS
    
    # Create a hash of options and their values
    def options
      options = {}
      VALID_OPTIONS_KEYS.each{|k| options[k] = send(k)}
      options
    end
       
  end
end