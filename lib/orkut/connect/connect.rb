require "oauth"
require 'multi_json'

module Orkut
  class Connect

    CONNECT = # "#{Network::CONFIG[Rails.env]['orkut']['connect_callback_url']}/timbeta/orkut/callback"
    LINK    = # "#{Network::CONFIG[Rails.env]['orkut']['connect_callback_url']}/timbeta/orkut/link_callback"

    # get authorization url
    # connecting as first provider
    def request_token
      consumer = initialize_consumer
      get_request_token consumer, CONNECT
    end

    # get authorization url 
    # linking providers
    def request_token_link
      consumer = initialize_consumer
      get_request_token consumer, LINK
    end

    # generic consumer initializer
    def initialize_consumer(consumer_key,consumer_secret)
      OAuth::Consumer.new( consumer_key, consumer_secret,
                            :site               => "https://www.google.com",
                            :request_token_path => '/accounts/OAuthGetRequestToken',
                            :access_token_path  => '/accounts/OAuthGetAccessToken',
                            :authorize_path     => '/accounts/OAuthAuthorizeToken')
    end

    # request token by callback
    def get_request_token(consumer, callback)
      request_token = consumer.get_request_token({
                      :scope          => 'http://orkut.gmodules.com/social/rest',
                      :oauth_callback => callback},
                      :scope          => 'http://orkut.gmodules.com/social')
    end
    
    
    # generic post json rpc call
    def post_json_rpc(consumer_key,consumer_secret, oauth_token, oauth_token_secret, subject)
        consumer = initialize_consumer consumer_key,consumer_secret
        token_hash = { :oauth_token => oauth_token, :oauth_token_secret => oauth_token_secret }
        access_token = OAuth::AccessToken.from_hash consumer, token_hash 
      
        data = access_token.post(Orkut::Config::DEFAULT_RPC_ENDPOINT, subject, 
                          { 'Content-Type' => 'application/json' }).body                        
                          
        MultiJson.decode data 
    end
        
  end  
end
