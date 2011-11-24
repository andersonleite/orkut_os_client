module Orkut
  module Client
    module Friends

      # get friends
      def friends (token, secret)
        consumer = initialize_consumer
        token_hash = { :oauth_token => token, :oauth_token_secret => secret }
        access_token = OAuth::AccessToken.from_hash consumer, token_hash 
        data = post_json_rpc access_token, FRIENDS
        data['data']['list']
      end

      # get friends
      def bestfriends (token, secret, friends)
        consumer = initialize_consumer
        token_hash = { :oauth_token => token, :oauth_token_secret => secret }
        access_token = OAuth::AccessToken.from_hash consumer, token_hash 

        list = []
        friends.each do |id|
          begin
            data = post_json_rpc access_token, mount_profile(id)

            id         = data['data']['id']
            givenName  = data['data']['name']['givenName']
            familyName = data['data']['name']['familyName']
            name = givenName + ' ' + familyName
            msg = data['data']['thumbnailUrl']
            user = {'name' => name, 'thumbnailUrl' => msg, 'id'  => id}

            list << user
          rescue Exception => e
            puts e.message
            puts e.backtrace.inspect
          end
        end  

        list

      end


      def scrapers(token, secret)
        consumer = initialize_consumer
        token_hash = { :oauth_token => token, :oauth_token_secret => secret }
        access_token = OAuth::AccessToken.from_hash(consumer, token_hash )

        scraps = access_token.post(RPC_ENDPOINT, '{
        "method" : "messages.get",
        "id" : "myself",
        "params" : {
        "userId" : "@me",
        "groupId" : "@friends",
        "pageType" : "first",
        "messageType" : "public_message"
        }
        }', 
        { 'Content-Type' => 'application/json' }).body

        data = MultiJson.decode(scraps)['data']['list']
        data.collect { |scrap| scrap['fromUserId'] }
      end   
      
    end
  end
end