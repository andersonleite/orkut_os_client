require "orkut/version"

module Orkut
  module Config

    # The endpoint that will be used to connect if none is set
    DEFAULT_RPC_ENDPOINT = 'http://sandbox.orkut.com/social/rpc'
    
    # The consumer key if none is set
    DEFAULT_CONSUMER_KEY = nil

    # The consumer secret if none is set
    DEFAULT_CONSUMER_SECRET = nil
    
    # An array of valid keys in the options hash when configuring a {Orkut::Client}
    VALID_OPTIONS_KEYS = [
      :consumer_key,
      :consumer_secret,
      :oauth_token,
      :oauth_token_secret,
      :callback_url
    ]

    attr_accessor *VALID_OPTIONS_KEYS
    
    # Create a hash of options and their values
    def options
      options = {}
      VALID_OPTIONS_KEYS.each{|k| options[k] = send(k)}
      options
    end
    
    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
      self
    end
       
  end
end