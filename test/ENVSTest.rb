module ENVS

require "test/unit"

require "lib/Common/logger"
require "lib/SBAStore/SBAObject"
require "lib/SBAStore/SBAStore"
require "lib/XMLDB/XMLParser"
require "lib/ENVS/Frame"
require "lib/ENVS/ENVS"
require "lib/QRES/QRES"
require "lib/QRES/ReferenceResult"

require "lib/Operator/Dotres"


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
        
        parser = XMLDB::XMLParser.new()
        
        store = parser.loadXML("sampledata/data.xml")
        
        envs = ENVS.new(store)
        
        bag = envs.bind("emp")
        
        referenceResult = QRES::ReferenceResult.new(SBAStore::SBAObject.VAR_IDENTIFIER_PREFIX + 2.to_s())
        
        envs.nested(referenceResult, store)
      }
    end
    
  end
       
end
