class Connect

  CONNECT = "#{Network::CONFIG[Rails.env]['orkut']['connect_callback_url']}/timbeta/orkut/callback"
  LINK    = "#{Network::CONFIG[Rails.env]['orkut']['connect_callback_url']}/timbeta/orkut/link_callback"

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
  
  private

  # generic consumer initializer
  def initialize_consumer
    OAuth::Consumer.new( Network::CONFIG[Rails.env]['orkut']['consumer_key'],
                         Network::CONFIG[Rails.env]['orkut']['consumer_secret'],
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
  def post_json_rpc(access_token, subject)
      data = access_token.post(RPC_ENDPOINT, subject, 
                        { 'Content-Type' => 'application/json' }).body                        
      MultiJson.decode data 
  end
end