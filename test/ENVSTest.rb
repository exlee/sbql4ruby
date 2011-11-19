module ENVS

require "test/unit"

require "lib/Common/logger"
require "lib/SBAStore/SBAStore"
require "lib/XMLDB/XMLParser"
require "lib/ENVS/Frame"
require "lib/ENVS/ENVS"
require "lib/QRES/ReferenceResult"


  class ENVSTest < Test::Unit::TestCase
  
    # Creates few SBA objects and puts those to the store.
    #
    # Params:
    #
    # Returns:
    #
    # Throws:   
    def test_SBAStore
      
      assert_nothing_thrown("Creating SBA objects") {  
        
        # Set debug log level
        Common::Logger.setLogLevel(Common::VAR_DEBUG)
        
        parser = XMLDB::XMLParser.new();
        
        store = parser.loadXML("sampledata/data.xml")
        
        puts store.to_s()
        
        envs = ENVS.new(store)
        
        bag = envs.bind("emp")
        
        #puts "Bag=" + bag.to_s()
        
        #puts bag.to_s()
        
        referenceResult = QRES::ReferenceResult.new(2)
        
        envs.nested(referenceResult, store)
        
        #puts envs.to_s()
        
        #frame = Frame.new(store)
        
        #puts "Test=" + frame.to_s()
      }
    end
    
  end
       
end
