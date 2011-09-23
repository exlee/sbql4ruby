module SBAStore
  
require "lib/SBAStore/SBAObject"
require "lib/Common/exceptions"


  # SBA store abstract class for simple objects 
  class SBASimpleObject < SBAObject

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
      super(var_Name, var_Object)
    end
    
    # Method:SBASimpleObject.isValidType?
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
    # Throws:SBANotImplementedError
    def SBASimpleObject.isValidType?(var_Object)
      raise SBANotImplementedError.new("Abstract method")
    end
         
  end
 
end