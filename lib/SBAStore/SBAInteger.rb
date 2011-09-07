module SBAStore
  
require "SBASimpleObject"
require "exceptions"


  # SBA store Integer class 
  class SBAInteger < SBASimpleObject
    
    # Method:initialize
    #
    # Params:
    #
    # var_Name:String - SBA store object name
    #
    # var_Object:Integer - SBA store object
    #
    # Returns:
    #
    # Throws:SBATypeError
    def initialize(var_Name, var_Object)
      if(!SBAInteger.isValidType?(var_Object))
        raise SBATypeError.new("Incorrect object type [#{var_Object.class}]")
      end
      
      super(var_Name, var_Object)
    end

    # Method:SBAInteger.isValidType?
    #
    # Validates given object's type
    #
    # Params:
    #
    # var_Object:Object - object to be validated
    #
    # Returns:TrueClass/FalseClass
    #
    # Throws:
    def SBAInteger.isValidType?(var_Object)
      if(var_Object.is_a? Integer)
        return true
      end
       
      return false
    end
      
  end
  
end