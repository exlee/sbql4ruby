module ENVS

require "test/unit"

require "lib/Common/logger"
require "lib/SBAStore/SBAStore"
require "lib/XMLDB/XMLParser"
require "lib/ENVS/Frame"
require "lib/ENVS/ENVS"


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
        Common::Logger.setLogLevel(Common::VAR_INFO)
        
        parser = XMLDB::XMLParser.new();
        
        store = parser.loadXML("sampledata/data.xml")
        
        envs = ENVS.new(store)
        
        #frame = Frame.new(store)
        
        #puts "Test=" + frame.to_s()
      }
    end
    
  end
       
end
