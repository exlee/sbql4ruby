module SBAStore

require "exceptions"


  # SBA store basic abstract class 
  class SBAObject

    # VAR_OBJECT_COUNTER:Integer - SBAObject instances counter
    @@VAR_OBJECT_COUNTER = 0
    
    # Method:initialize
    #
    # Params:
    #
    # var_Name:String - SBA store object name
    # var_Object:Object - SBA store encapsulated object
    #
    # Returns:
    #
    # Throws:
    def initialize(var_Name, var_Object)
      @VAR_ID = @@VAR_OBJECT_COUNTER
      @VAR_NAME = var_Name
      @VAR_OBJECT = var_Object
      
      @@VAR_OBJECT_COUNTER += 1
    end

    # Method:SBAObject.isValidType?
    #
    # Abstract method, should be implemented by the inheriting 
    # classes (valids given object)
    #
    # Params:
    #
    # var_Object:Object - object to be validated
    #
    # Returns:
    #
    # Throws: SBANotImplementedError
    def SBAObject.isValidType?(var_Object)
      raise SBANotImplementedError.new("Abstract method")
    end
    
    # Method:VAR_OBJECT_COUNTER
    #
    # Gets SBAObjects instance counter
    #
    # Params:
    #
    # Returns: VAR_OBJECT_COUNTER:INTEGER
    #
    # Throws:
    def VAR_OBJECT_COUNTER
      @@VAR_OBJECT_COUNTER
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
      return "ID=[" + @VAR_ID.to_s() + "], Name=[" + @VAR_NAME + "], Value=[" + @VAR_OBJECT.to_s() + "]"
    end
    
    # VAR_ID:Integer - SBA store object identifier
    attr :VAR_ID
    
    # VAR_NAME:String - SBA store object name
    attr :VAR_NAME
    
    # VAR_OBJECT:Object - SBA store encapsulated object
    attr :VAR_OBJECT
         
  end
 
end
