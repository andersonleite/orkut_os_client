require "orkut/captcha"

module Orkut
  class Client
    module Scraps
      
      # get scraps
      def scraps
        Orkut::Connect.new.post_json_rpc self, Orkut::RPC::SCRAPS
      end
      
      def send_scrap_with_captcha(token, secret, friend_social_id, msg, captchaAnswer, captchaValue)

        consumer = initialize_consumer

        token_hash = { :oauth_token => token, :oauth_token_secret => secret }
        access_token = OAuth::AccessToken.from_hash(consumer, token_hash )

        data = "
        [
        {
        'method' : 'captcha.answer',
        'id' : 'myself',
        'params' : 
        {
        'userId' : '@me',
        'groupId' : '@self',
        'captchaAnswer' : '#{captchaAnswer}',
        'captchaToken' : '#{captchaValue}'
        }
        }
        ,
        {
        'method' : 'messages.create',
        'id' : 'myself',
        'params' : 
        {
        'userId' : '#{friend_social_id}',
        'groupId' : '@self',
        'message' : 
        {
        'recipients' : '#{friend_social_id}',
        'body' : '#{msg}', 
        'title' : 'teste',
        },
        'messageType' : 'public_message'
        }
        }
        ]
        "
  
        result = access_token.post(RPC_ENDPOINT, data, { 'Content-Type' => 'application/json' }).body
  
      end


      def send_scrap(friend_social_id, msg)
    
        data = "
        {
        'method' : 'messages.create',
        'id' : 'myself',
        'params' : 
        {
        'userId' : '#{friend_social_id}',
        'groupId' : '@self',
        'message' : 
        {
        'recipients' : '#{friend_social_id}',
        'body' : '#{msg}', 
        'title' : 'Chip',
        },
        'messageType' : 'public_message'
        }
        }"
  
        Orkut::Connect.new.post_json_rpc self, data
      end
      
    end
  end
end