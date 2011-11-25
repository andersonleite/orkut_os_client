require "helper"

describe Orkut do
  
  context "when using orkut client" do
    
    before do
      # stub_post("").
      # to_return(:body => fixture("profile.json"), :headers => {:content_type => "application/json; charset=utf-8"})
      
      @orkut = Orkut.new(:consumer_key       => 'tictacfight.heroku.com',
                         :consumer_secret    => 'F_d-RByVwEJe2hV2fE7jo2l5',
                         :oauth_token        => '1/uSnaAxVdx6SOs0pAjkQO3iC3h-N9Lng4U3N1Q8tivOc',
                         :oauth_token_secret => '9I6LlarEUjGLBrt2fb3eslyn')
      
    end
            
    it  "should get the user profile" do
      @orkut.should_not be_nil

      data = @orkut.profile
      data['data']['name']['givenName'].should  be == 'Anderson'
      data['data']['name']['familyName'].should be == 'Leite'
    end
    
  end
end  