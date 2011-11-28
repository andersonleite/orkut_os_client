# Orkut OS Client
A Ruby wrapper for the Orkut RPC-JSON API.

## Installation
`gem install 'orkut_os_client'`


Get Data
orkut = Orkut.new( :consumer_key       => "YOUR_CONSUMER_KEY",
           :consumer_secret    => "YOUR_CONSUMER_SECRET",
           :oauth_token        => session[:token],
           :oauth_token_secret => session[:secret] )

orkut.profile
orkut.scraps
orkut.friends
orkut.albums

Get Authorization
Firt, you need access_pass(token and secret) 

class OrkutController < ApplicationController

  def connect

    orkut = Orkut.configure do |config|
      config.consumer_key = "YOUR_CONSUMER_KEY"
      config.consumer_secret = "YOUR_CONSUMER_SECRET"
      config.callback_url = "http://localhost:3000/auth/orkut_callback"
    end

    session[:request_token] = orkut.request_token
    redirect_to session[:request_token].authorize_url
  end

  def connect_callback
    access_token = session[:request_token].get_access_token(:oauth_verifier => params[:oauth_verifier])
    session[:token]  = access_token.token
    session[:secret] = access_token.secret
    render "index"
  end

end
