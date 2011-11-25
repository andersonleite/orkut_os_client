module Orkut
  class Client
    module Albums

      def albums
        Orkut::Connect.new.post_json_rpc self, Orkut::RPC::ALBUMS
      end
   
    end
  end
end