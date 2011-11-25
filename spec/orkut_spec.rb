require "helper"
require "keys"

describe Orkut do
  
  context "when using orkut client" do
    
    before do
      # stub_post("").
      # to_return(:body => fixture("profile.json"), :headers => {:content_type => "application/json; charset=utf-8"})
      
      @orkut = Orkut.new(:consumer_key       => Access::Keys::CONSUMER_KEY,
                         :consumer_secret    => Access::Keys::CONSUMER_SECRET,
                         :oauth_token        => Access::Keys::OAUTH_TOKEN,
                         :oauth_token_secret => Access::Keys::OAUTH_TOKEN_SECRET)
      
    end
            
    it  "should get the user profile" do
      @orkut.should_not be_nil

      data = @orkut.profile
      data['data']['name']['givenName'].should  be == 'Anderson'
      data['data']['name']['familyName'].should be == 'Leite'
    end
    
    it "should get user's friends" do
      @orkut.should_not be_nil
      data = @orkut.friends
      data.should_not be_nil
    end

    it "should get user's scraps" do
      @orkut.should_not be_nil
      data = @orkut.scraps
      data.should_not be_nil
    end

    it "should get user's albums" do
      @orkut.should_not be_nil
      data = @orkut.albums
      data.should_not be_nil
    end
    
  end
end  