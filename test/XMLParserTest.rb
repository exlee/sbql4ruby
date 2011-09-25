module XMLDB

#$:<< "/Users/mqs74/Dropbox/Workspace/sbql4ruby/lib/Common"
#$:<< "/Users/mqs74/Dropbox/Workspace/sbql4ruby/lib/SBAStore"
#$:<< "/Users/mqs74/Dropbox/Workspace/sbql4ruby/lib/XMLDB"
  
require "test/unit"

require 'lib/Common/logger'


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
        require "lib/XMLDB/XMLParser"
        
        # Set debug log level
        Common::Logger.setLogLevel(Common::VAR_INFO)
        
        parser = XMLParser.new();
        
        var_store = parser.loadXML("sampledata/data.xml")
        
        puts "Stack:\n" + var_store.to_s()
      }
    end
    
  end
  
end