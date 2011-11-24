module Orkut
  module Client
    module Profile

      # get profile data
      def profile(access_token, id='@me')
        data = post_json_rpc access_token, mount_profile(id)
      end

    end
  end
end