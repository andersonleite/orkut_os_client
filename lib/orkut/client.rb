module Orkut

  class Client
   
   # Initializes a new API object
   #
   # @return [Orkut::Client]
   def initialize(attrs={})
      attrs = Orkut.options.merge(attrs)
      Config::VALID_OPTIONS_KEYS.each do |key|
        instance_variable_set("@#{key}".to_sym, attrs[key])
      end   
    end 
   
   FRIENDS = '{ "method" : "people.get", "id" : "myself", "params" : { "userId" : "@me", "groupId" : "@friends", "count" : 999} }'

    def mount_profile(id)
      "{ 'method' : 'people.get', 'id' : 'myself', 'params' : { 'userId' : '#{id}', 'groupId' : '@self' } }"    
    end
   
   
  end
  
end