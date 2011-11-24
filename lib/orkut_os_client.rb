require "orkut/client"
require "orkut/config"

module Orkut
  extend Config
  
  class << self
  
    # Alias for Orkut::Client.new
    # return [Orkut::Client]
    def new(options={})
      Orkut::Client.new(options)
    end
    
  end
end