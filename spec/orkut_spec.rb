require "helper"

describe Orkut do
  
  context "when using orkut client" do
    
    before do
      # stub
    end
    
    it  "should get the user profile" do
      orkut = Orkut.new(:consumer_key => 'AAA', :consumer_secret => 'AAA', :token => 'AAA', :secret => 'AAA')
      orkut.should_not be_nil
    end
    
  end
end  