module XMLDB
  
require "rexml/document"
require "exceptions"
require "SBAStore"

require "Listener"


  class XMLParser
     
    # Method:XMLParser.validXML?
    #
    # Valids given XML data
    #
    # Params:
    #
    # var_Identifier:String - XML data
    #
    # Returns:
    #
    # Throws:IncorrectFileNameException
    def loadXML(var_FileName)
      if(var_FileName == nil || var_FileName == "")
        raise IncorrectFileNameException.new("#{var_FileName}")
      end
      
      var_Store = SBAStore::SBAStore.new()
      
      var_File = File.open(var_FileName, "r")
      var_Listener = XMLDB::Listener.new(var_Store)
      
      REXML::Document.parse_stream(var_File, var_Listener)
      
      puts "Stack:\n" + var_Store.to_s()
    end
    
    # Method:XMLParser.validXML?
    #
    # Valids given XML data
    #
    # Params:
    #
    # var_Identifier:String - XML data
    #
    # Returns:TrueClass || FalseClass
    def XMLParser.validXML?(var_FileData)
        REXML::Document.new(var_FileData)
    end
    
  end
  
end