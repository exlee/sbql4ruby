module XMLDB

#$:<< "/Users/mqs74/Dropbox/Workspace/sbql4ruby/lib/Common"
#$:<< "/Users/mqs74/Dropbox/Workspace/sbql4ruby/lib/SBAStore"
#$:<< "/Users/mqs74/Dropbox/Workspace/sbql4ruby/lib/XMLDB"
  
require "test/unit"

require 'lib/Common/logger'


  class XMLParserTest < Test::Unit::TestCase
   
    def test_ParseXML
      assert_nothing_thrown("Checking for RubyGem") {
        require "lib/XMLDB/XMLParser"
        
        # Set debug log level
        Common::Logger.setLogLevel(Common::VAR_DEBUG)
        
        parser = XMLParser.new();
        
        parser.loadXML("sampledata/data.xml")
      }
    end
    
  end
  
end