module XMLDB
  
require "rexml/document"

require "lib/Common/exceptions"
require "lib/SBAStore/SBAStore"
require "lib/XMLDB/Listener"


  # Class: XMLParser
  # 
  # Class which implements XML parser for SBAStore use
  class XMLParser
     
    # Method: loadXML
    #
    # Loads given XML data and builds SBA store.
    #
    # Params:
    #
    # var_Identifier:String - XML data
    #
    # Returns:SBAStore
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
      
      # Listener does not guarantees the object will be sorted by object's identifier
      # So, it needs to be sorted, because store looks a root node with array identifier
      # equals 0
      var_Store.sortByObjectIdentifier()
        
      return var_Store
    end
    
    # Static Method: validXML?
    #
    # Valids given XML data.
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
