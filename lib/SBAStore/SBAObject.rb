module SBAStore

require "lib/Common/exceptions"


  # SBA store basic abstract class. 
  class SBAObject

    # VAR_IDENTIFIER_PREFIX - Identifier prefix
    @@VAR_IDENTIFIER_PREFIX = "SBA"
    
    # VAR_OBJECT_COUNTER:Integer - SBAObject instances counter
    @@VAR_OBJECT_COUNTER = 0
    
    # Params:
    #
    # var_Name:String - SBA store object name
    #
    # var_Object:Object - SBA store encapsulated object
    #
    # var_ID:String - SBA object identifier, if nil SBAObject will create default identifier
    #
    # Returns:
    #
    # Throws:
    def initialize(var_Name, var_Object, var_ID=nil)
      if(var_ID==nil)
        @VAR_ID = @@VAR_IDENTIFIER_PREFIX + @@VAR_OBJECT_COUNTER.to_s()
      else
        @VAR_ID = var_ID
      end
      
      @VAR_NAME = var_Name
      @VAR_OBJECT = var_Object
      
      @@VAR_OBJECT_COUNTER += 1
    end

    # Abstract method, should be implemented by the inheriting 
    # classes (valids given object).
    #
    # Params:
    #
    # var_Object:Object - object to be validated
    #
    # Returns:
    #
    # Throws: AbstractMethodException
    def SBAObject.isValidType?(var_Object)
      raise AbstractMethodException.new("Abstract method")
    end
    
    # Gets SBAObjects instance counter.
    #
    # Params:
    #
    # Returns: VAR_OBJECT_COUNTER:INTEGER
    #
    # Throws:
    def SBAObject.VAR_OBJECT_COUNTER
      @@VAR_OBJECT_COUNTER
    end
    
    # Gets SBAObjects default identifier's prefix.
    #
    # Params:
    #
    # Returns: VAR_OBJECT_COUNTER:INTEGER
    #
    # Throws:
    def SBAObject.VAR_IDENTIFIER_PREFIX
      @@VAR_IDENTIFIER_PREFIX
    end    
    
    # Gets current object's identifier.
    #
    # Params:
    #
    # Returns: VAR_OBJECT_COUNTER:INTEGER
    #
    # Throws:
    def VAR_OBJECT_COUNTER
      @@VAR_OBJECT_COUNTER
    end
    
    # Returns a string representation of SBAObject.
    #
    # Params:
    #
    # Returns:String
    #
    # Throws:
    def to_s
      if(@VAR_OBJECT == nil)
        return "ID=[" + @VAR_ID.to_s() + "], Name=[" + @VAR_NAME + "], Value=[nil]"
      else
        return "ID=[" + @VAR_ID.to_s() + "], Name=[" + @VAR_NAME + "], Value=[" + @VAR_OBJECT.to_s() + "], Type=[" + @VAR_OBJECT.class.to_s() + "]"
      end
    end
    
    # VAR_ID:String - SBA store object identifier
    attr_reader :VAR_ID
    
    # VAR_NAME:String - SBA store object name
    attr_reader :VAR_NAME
    
    # VAR_OBJECT:Object - SBA store encapsulated object
    attr_reader :VAR_OBJECT
         
  end
 
end
