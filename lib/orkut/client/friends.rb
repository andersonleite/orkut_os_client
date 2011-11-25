module Orkut
  class Client
    module Friends

      # get friends
      def friends
        Orkut::Connect.new.post_json_rpc self, Orkut::RPC::FRIENDS
      end
   
    end
  end
end