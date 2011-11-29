# Orkut OS Client
A Ruby wrapper for the Orkut RPC-JSON API.

## Installation
```   
    gem install 'orkut_os_client'
```


## Get Data
Create you orkut connect client simple as:

```
    orkut = Orkut.new( :consumer_key       => "YOUR_CONSUMER_KEY",
                       :consumer_secret    => "YOUR_CONSUMER_SECRET",
                       :oauth_token        => "YOUR_OAUTH_TOKEN",
                       :oauth_token_secret => "YOUR_OAUTH_TOKEN_SECRET" )
```                    

You have access to Orkut data using:

`
    orkut.profile
    orkut.scraps
    orkut.friends
    orkut.albums
`

## Get Authorization
For web-aplications, users need to authorize your app in order to give you the access pass.
Create a controller like that:

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

end`
