module XMLDB

#$:<< "/Users/mqs74/Dropbox/Workspace/sbql4ruby/lib/Common"
#$:<< "/Users/mqs74/Dropbox/Workspace/sbql4ruby/lib/SBAStore"
#$:<< "/Users/mqs74/Dropbox/Workspace/sbql4ruby/lib/XMLDB"
  
require "test/unit"

require "lib/Common/logger"
require "lib/XMLDB/XMLParser"



  class XMLParserTest < Test::Unit::TestCase
   
    # Loads correct XML test file and builds SBA store.
    #
    # Params:
    #
    # Returns:
    #
    # Throws:
    def test_ParseXML
      assert_nothing_thrown("Checking for RubyGem") {
        
        # Set debug log level
        Common::Logger.setLogLevel(Common::VAR_INFO)
        
        parser = XMLParser.new();
        
        store = parser.loadXML("sampledata/data.xml")
        
        assert_equal(26, store.VAR_OBJECTS.size())
        assert_equal("s0001", store.find(16).VAR_OBJECT)
        
        puts "Stack:\n" + store.to_s()
      }
    end
    
  end
  
end