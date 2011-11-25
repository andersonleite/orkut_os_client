module Orkut
  module RPC
    
    SCRAPS = '{
                "method" : "messages.get",
                "id"     : "myself",
                "params" : 
                {
                  "userId"      : "@me",
                  "groupId"     : "@friends",
                  "pageType"    : "first",
                  "messageType" : "public_message"
                }
              }'
              
    FRIENDS = '{ 
               "method" : "people.get",
               "id"     : "myself",
               "params" : 
               { 
                 "userId"  : "@me", 
                 "groupId" : "@friends", 
                 "count"   : 999
                } 
              }'
    
    ALBUMS =  '{
                "method" : "albums.get",
                "id"     : "myself",
                "params" : 
                {
                  "userId"  : "@me",
                  "groupId" : "@self"
                }
              }'
    
  end
end