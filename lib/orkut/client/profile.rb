require "orkut/connect/connect"

module Orkut
  class Client
    module Profile

      # get profile data
      def profile(id='@me')
        Orkut::Connect.new.post_json_rpc self, mount_profile(id)
      end

      private
      def mount_profile(id)
        "{ 'method' : 'people.get', 'id' : 'myself', 'params' : { 'userId' : '#{id}', 'groupId' : '@self' } }"    
      end

    end
  end
end