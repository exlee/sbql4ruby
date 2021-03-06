module SBAStore
  
require "lib/SBAStore/SBAObject"
require "lib/Common/exceptions"


  # Class: SBASimpleObject
  # Extends: SBAObject
  #
  # SBA store abstract class for simple objects 
  class SBASimpleObject < SBAObject

    # Method: initialize (constructor)
    #
    # Params:
    #
    # var_Name:String - SBA store object name
    #
    # var_Object:Object - SBA store encapsulated object
    #
    # var_ID:String - SBA object identifier
    #
    # Returns:
    #
    # Throws:
    def initialize(var_Name, var_Object, var_ID=nil)
      super(var_Name, var_Object, var_ID)
    end
    
    # Static Method: isValidType?
    #
    # Abstract method, should be implemented by the inheriting 
    # classes (valids given object).
    #
    # Params:
    #
    # var_Object:Object - object to be validated
    #
    # Returns:
    #
    # Throws:AbstractMethodException
    def SBASimpleObject.isValidType?(var_Object)
      raise AbstractMethodException.new("Abstract method")
    end
    
    # Method: to_qres
    #
    # Abstract method, should be implemented by the inheriting 
    # classes (valids given object).
    #
    # Params:
    #
    # Returns:
    #
    # Throws:AbstractMethodException
    def to_qres()
      raise AbstractMethodException.new("Abstract method")
    end
         
  end
 
end
