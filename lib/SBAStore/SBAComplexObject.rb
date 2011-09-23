module SBAStore
  
require "lib/SBAStore/SBAObject"
require "lib/Common/exceptions"


  # SBA store abstract class for simple objects 
  class SBAComplexObject < SBAObject

    # Method:initialize
    #
    # Params:
    #
    # var_Name:String - SBA store object name
    # var_Object:Object - SBA store complex data object
    #
    # Returns:
    #
    # Throws:
    def initialize(var_Name)
      super(var_Name, nil)
      
      @VAR_REFERENCES = Array.new()
    end
    
    # Method:add
    #
    # Adds a new object's identifier to the complex obejct 
    # (as attribute). 
    #
    # Params:
    #
    # var_Id:Integer - SBA store object's identifier
    #
    # Returns:
    #
    # Throws:SBATypeError, SBAIncorrectIdentifierError
    def add(var_Id)
      if(!var_Id.is_a?(Integer))
        raise SBATypeError.new("Incorrect object type [#{var_Object.class}]")
      end
      
      if(find(var_Id) != nil)
        raise SBAIncorrectIdentifierError.new("Given object's identifier [#{var_Identifier}] is already joined")
      end
      
      @VAR_REFERENCES.push(var_Id)
    end

    # Method:is_a?
    #
    # Compares given object's type with it's type,
    # returns true if those objects' types are
    # the same.
    #
    # Params:
    #
    # var_Identifier:Integer - SBA store object's identifier
    #
    # Returns:Integer
    #
    # Throws: 
    def is_a?(var_Object)
      if(SBASimpleObjectFactory.class == var_Object.class)
        return true
      end
      
      return false
    end
    
    # Method:find
    #
    # Finds the given SBA object's identifier and returns array index
    #
    # Params:
    #
    # var_Identifier:Integer - SBA store object's identifier
    #
    # Returns:Integer
    #
    # Throws: 
    def find(var_Identifier)
      return @VAR_REFERENCES.index(var_Identifier)
    end

    # Method:to_s
    #
    # Returns a string representation of SBAObject
    #
    # Params:
    #
    # Returns: String
    #
    # Throws:
    def to_s
       var_text = "ID=[" + @VAR_ID.to_s() + "], Name=[" + @VAR_NAME + "], indexes: ["

        @VAR_REFERENCES.each{|object| var_text += " " + object.to_s()}

        return var_text + " ]"
    end
          
    # Method:push
    #
    # Alias for find method 
    #
    # Params:
    #
    # var_Identifier:Integer - SBA store object's identifier
    #
    # Returns:Integer
    #
    # Throws:
    alias push add
  
    # VAR_REFERENCES:Integer - Collection of SBA objects' identifiers
    attr :VAR_REFERENCES
    
  end

end