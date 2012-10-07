module Operator

require "test/unit"

require "lib/Common/logger"
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
    def test_DotresOperator
      
      assert_nothing_thrown("Creating SBA objects") {  
        
        # Set debug log level
        Common::Logger.setLogLevel(Common::VAR_DEBUG)
        
        parser = XMLDB::XMLParser.new()
        
        store = parser.loadXML("sampledata/data.xml")
        
        envs = ENVS::ENVS.new(store)
        qres = QRES::QRES.new()
        
        Operator::Dotres.eval("emp", "address", qres, envs, store)
        
      }
    end
    
  end
       
end
