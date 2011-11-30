# A utility for signing an url using OAuth in a way that's convenient for debugging
# Note: the standard Ruby OAuth lib is here http://github.com/mojodna/oauth
# License: http://gist.github.com/375593

require 'uri'
require 'openssl'
require 'base64'

class Oauth
  
  attr_accessor :consumer_key, :consumer_secret, :token, :token_secret, :req_method, :sig_method, :oauth_version, :callback_url, :params
  
  def initialize
    @consumer_key = ''
    @consumer_secret = ''
    @token = ''
    @token_secret = ''
    @req_method = 'GET'
    @sig_method = 'HMAC-SHA1'
    @oauth_version = '1.0'
    @callback_url = ''
    @params = []
  end
  
  # openssl::random_bytes returns non-word chars, which need to be removed. using alt method to get consistent length
  # ref http://snippets.dzone.com/posts/show/491
  def generate_nonce
    Array.new( 5 ) { rand(256) }.pack('C*').unpack('H*').first
  end
  
  def percent_encode( string )
    
    # ref http://snippets.dzone.com/posts/show/1260
    URI.escape( string, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]") )
  end
  
  # sort (very important as it affects the signature), concat, and percent encode
  # @ref http://oauth.net/core/1.0/#rfc.section.9.1.1
  # @ref http://oauth.net/core/1.0/#9.2.1
  # @ref http://oauth.net/core/1.0/#rfc.section.A.5.1
  def normalize_req_params( params )
    percent_encode( params.sort().join( '&' ) )
  end
  
  # @ref http://oauth.net/core/1.0/#rfc.section.9.1.2
  def construct_req_url( url)
    parsed_url = URI.parse( url )
    parsed_url.scheme + '://' + parsed_url.host + parsed_url.path
  end
  
  # @ref http://oauth.net/core/1.0/#rfc.section.9.2
  def generate_sig( args )
    key = percent_encode( args[:consumer_secret] ) + '&' + percent_encode( args[:token_secret] )
    text = args[:base_str]
    
    # credit: http://blog.nathanielbibler.com/post/63031273/openssl-hmac-vs-ruby-hmac-benchmarks
    digest = OpenSSL::Digest::Digest.new( 'sha1' )
    raw_sig = OpenSSL::HMAC.digest( digest, key, text )
    
    # ref http://groups.google.com/group/oauth-ruby/browse_thread/thread/9110ed8c8f3cae81
    Base64.encode64( raw_sig ).chomp.gsub( /\n/, '' )
  end
  
  def to_query_string
    @params.find_all{ | item | item =~ /oauth_.*/ }.join( '&' )
  end
  
  def to_header_string
    pairs = []

    # format string as key1="val1", key2="val2" ...
    @params.find_all{ | item | item =~ /oauth_.*/ }.each{ | item |
      pair = '%s="%s"' % item.split( '=' )
      pairs.push( pair )
    }
    pairs.join( ', ' )
  end
  
  def sign( url )
    
    parsed_url = URI.parse( url )
    
    # basic oauth params formatted as strings in array so we can easily sort
    @params.push( 'oauth_consumer_key=' + @consumer_key )
    @params.push( 'oauth_nonce=' + generate_nonce() )
    @params.push( 'oauth_signature_method=' + @sig_method )
    @params.push( 'oauth_timestamp=' + Time.now.to_i.to_s )
    @params.push( 'oauth_version=' + @oauth_version )

    # if params passed in, add them & replace defaults
    if parsed_url.query
      @params = @params | parsed_url.query.split( '&' )
    end
    
    # elems for base str
    normal_req_params = normalize_req_params( params )
    
    # @ref http://oauth.net/core/1.0/#rfc.section.9.1.2
    req_url = parsed_url.scheme + '://' + parsed_url.host + parsed_url.path

    # create base str
    base_str = [ @req_method, percent_encode( req_url ), normal_req_params ].join( '&' )

    # sign
    signature = generate_sig({
      :base_str => base_str,
      :consumer_secret => @consumer_secret,
      :token_secret => @token_secret
    })

    @params.push( 'oauth_signature=' + percent_encode( signature ) )
    
    return self
  end
end

