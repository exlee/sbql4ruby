module SBAStore
  
require "lib/SBAStore/SBAObject"
require "lib/SBAStore/SBAComplexObjectIterator"

require "lib/Common/exceptions"


  # Class: SBAComplexObject
  # Extends: SBAObject
  #
  # SBA store class for simple objects 
  class SBAComplexObject < SBAObject

    # Method: initialize (constructor)
    #
    # Params:
    #
    # var_Name:String - SBA store object name
    #
    # var_ID:String - SBA object identifier
    #
    # Returns:
    #
    # Throws:
    def initialize(var_Name, var_ID=nil)
      super(var_Name, Array.new(), var_ID)
    end
    
    # Method: add
    #
    # Adds a new object's identifier to the complex obejct 
    # (as attribute). 
    #
    # Params:
    #
    # var_Id:String - SBA store object's identifier
    #
    # Returns:
    #
    # Throws:SBATypeError, SBAIncorrectIdentifierError
    def add(var_Id)
      if(!var_Id.is_a?(String))
        raise SBATypeError.new("Incorrect object type [#{var_Id.class.to_s()}]")
      end
      
      if(find(var_Id) != nil)
        raise SBAIncorrectIdentifierError.new("Given object's identifier [#{var_Identifier}] is already joined")
      end
      
      @VAR_OBJECT.push(var_Id)
    end
    
    # Method: find
    #
    # Finds the given SBA object's identifier and returns array index.
    #
    # Params:
    #
    # var_Identifier:Integer - SBA store object's identifier
    #
    # Returns:Integer
    #
    # Throws: 
    def find(var_Identifier)
      return @VAR_OBJECT.index(var_Identifier)
    end

    # Method: get
    #
    # Returns SBA object taken from the array using given array index.
    #
    # Params:
    #
    # var_Index:String - array index
    #
    # Returns:SBAObject
    #
    # Throws: 
    def get(var_Index)
      return @VAR_OBJECT[var_Index]
    end

    # Method: iterator
    #
    # Returns iterator.
    #
    # Params:
    #
    # Returns:SBAComplexObjectIterator
    #
    # Throws:
    def iterator()
      return SBAComplexObjectIterator.new(self)
    end
    
    # Method: is_a?
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
         
    # Method: to_s
    #
    # Returns a string representation of SBAObject.
    #
    # Params:
    #
    # Returns: String
    #
    # Throws:
    def to_s()
       var_text = "ID=[" + @VAR_ID.to_s() + "], Name=[" + @VAR_NAME + "], indexes: ["

        @VAR_OBJECT.each{|object| var_text += " " + object.to_s()}

        return var_text + " ]"
    end
    
    
    # Alias for find method.
    #
    # Params:
    #
    # var_Identifier:Integer - SBA store object's identifier
    #
    # Returns:Integer
    #
    # Throws:
    alias push add

    
  end

end
