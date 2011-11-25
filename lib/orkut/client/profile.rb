require "orkut/connect/connect"

module Orkut
  class Client
    module Profile

      # get profile data
      def profile(id='@me')
        Orkut::Connect.new.post_json_rpc self.consumer_key, self.consumer_secret, self.oauth_token, self.oauth_token_secret, mount_profile(id)
      end

      private
      def mount_profile(id)
        "{ 'method' : 'people.get', 'id' : 'myself', 'params' : { 'userId' : '#{id}', 'groupId' : '@self' } }"    
      end

    end
  end
end