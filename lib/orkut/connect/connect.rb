require "oauth"
require 'multi_json'

module Orkut
  class Connect

    # generic consumer initializer
    def initialize_consumer(client)
      OAuth::Consumer.new( client.consumer_key, client.consumer_secret,
                            :site               => "https://www.google.com",
                            :request_token_path => '/accounts/OAuthGetRequestToken',
                            :access_token_path  => '/accounts/OAuthGetAccessToken',
                            :authorize_path     => '/accounts/OAuthAuthorizeToken')
    end    
    
    # generic post json rpc call
    def post_json_rpc(client, subject)
        consumer = initialize_consumer client
        token_hash = { :oauth_token => client.oauth_token, :oauth_token_secret => client.oauth_token_secret }
        access_token = OAuth::AccessToken.from_hash consumer, token_hash 
      
        data = access_token.post(Orkut::Config::DEFAULT_RPC_ENDPOINT, subject, 
                          { 'Content-Type' => 'application/json' }).body                        
                          
        MultiJson.decode data 
    end
        
  end  
end
