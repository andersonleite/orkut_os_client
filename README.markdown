# Orkut OS Client
A Ruby wrapper for the Orkut RPC-JSON API.

## Install
```   
gem "orkut_os_client", "~> 0.1.0"
```

## Demo
You can see a demo web app here: http://orkut.heroku.com/

## Get Data
Create you orkut connect client simple as:

```
orkut = Orkut.new( :consumer_key       => "YOUR_CONSUMER_KEY",
                   :consumer_secret    => "YOUR_CONSUMER_SECRET",
                   :oauth_token        => "YOUR_OAUTH_TOKEN",
                   :oauth_token_secret => "YOUR_OAUTH_TOKEN_SECRET" )
```                    

You have access to Orkut data using:

```
orkut.profile
orkut.scraps
orkut.friends
orkut.albums
```

## Get Authorization
For web-aplications, users need to authorize your app in order to give you the access pass.
Create a controller like that:

```
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
```

## Sending Scraps
After initializing orkut_client you can call send_scrap method:

```
 orkut_client.send_scrap(params[:id], "Orkut OS Client")
```

## Other versions
This library is a result of Java version reverse engineering.
[Java version](http://code.google.com/p/orkut-os-client/)
[PHP version](http://code.google.com/p/orkut-os-client-php/) (by Robson Dantas) 