module Orkut
  class Captcha

    def captcha_image(token, secret, captcha_token_id)

       begin

         consumer = initialize_consumer

         token_hash = { :oauth_token => token, :oauth_token_secret => secret }
         access_token = OAuth::AccessToken.from_hash(consumer, token_hash )

          o = Oauth.new
          o.consumer_key    = Network::CONFIG[Rails.env]['orkut']['consumer_key']
          o.consumer_secret = Network::CONFIG[Rails.env]['orkut']['consumer_secret']

          url = "http://sandbox.orkut.com/social/pages/captcha?xid=#{captcha_token_id}"

          require 'net/http'

          parsed_url = URI.parse( url )

          result = ''
          Net::HTTP.start( parsed_url.host ) {|http|
            final_url = "#{url}?#{o.sign( url ).to_query_string() }"
            result = access_token.get(final_url)
          }

          return result

        rescue Exception => e
          puts e.message
          puts e.backtrace.inspect
        end

    end
    
  end
end

