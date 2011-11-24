module Orkut
  module Client
    module Datapoints

      # get datapoints
      # refactor here
      def datapoints (token, secret)
        orkut_datapoints = []

        consumer = initialize_consumer
        token_hash = { :oauth_token => token, :oauth_token_secret => secret }
        access_token = OAuth::AccessToken.from_hash(consumer, token_hash )

        friends = access_token.post(RPC_ENDPOINT, '{
        "method" : "people.get",
        "id" : "myself",
        "params" : {
        "userId" : "@me",
        "groupId" : "@friends"
        }
        }', 
        { 'Content-Type' => 'application/json' }).body
        orkut_datapoints << MultiJson.decode(friends)['data']['totalResults']

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
        orkut_datapoints << MultiJson.decode(scraps)['data']['totalResults']

        albums = access_token.post(RPC_ENDPOINT, '{
        "method" : "albums.get",
        "id" : "myself",
        "params" : {
        "userId" : "@me",
        "groupId" : "@self"
        }
        }', 
        { 'Content-Type' => 'application/json' }).body
        orkut_datapoints << MultiJson.decode(albums)['data']['totalResults']

        orkut_datapoints
      end

    end      
  end      
end      