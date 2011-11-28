module Orkut
  class Connect
    module Request

      # get authorization url
      # connecting as first provider
      def request_token
        consumer = Orkut::Connect.new.initialize_consumer self
        get_request_token consumer, self.callback_url
      end

      # request token by callback
      def get_request_token(consumer, callback)
        request_token = consumer.get_request_token({
                        :scope          => 'http://orkut.gmodules.com/social/rest',
                        :oauth_callback => callback},
                        :scope          => 'http://orkut.gmodules.com/social')
      end

    end  
  end  
end