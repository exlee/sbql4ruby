module XMLDB
  
$:<< "/Users/mqs74/Dropbox/Workspace/sbql4ruby/lib/SBAStore"
$:<< "/Users/mqs74/Dropbox/Workspace/sbql4ruby/lib/XMLDB"
  
require "test/unit"
   

  class XMLParserTest < Test::Unit::TestCase
   
    def test_ParseXML
      assert_nothing_thrown("Checking for RubyGem") {
        require "XMLParser"
        
        parser = XMLParser.new();
        
        parser.loadXML("../sampledata/data.xml")
      }
    end
    
  end
  
end