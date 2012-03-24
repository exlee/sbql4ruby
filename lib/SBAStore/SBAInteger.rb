module SBAStore
  
require "lib/SBAStore/SBASimpleObject"
require "lib/Common/exceptions"

require "lib/QRES/IntegerResult"


  # Class: SBAInteger
  # Extends: SBASimpleObject
  #
  # SBA store Integer class 
  class SBAInteger < SBASimpleObject
    
    # Method: initialize (constructor)
    #
    # Params:
    #
    # var_Name:String - SBA store object name
    #
    # var_Object:Integer - SBA store object
    #
    # var_ID:String - SBA object identifier
    #
    # Returns:
    #
    # Throws:SBATypeError
    def initialize(var_Name, var_Object, var_ID=nil)
      if(!SBAInteger.isValidType?(var_Object))
        raise SBATypeError.new("Incorrect object type [#{var_Object.class}], Integer expected")
      end
      
      super(var_Name, var_Object, var_ID)
    end

    # Static method: isValidType?
    #
    # Validates given object's type.
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
    
    # Static Method: fromString
    #
    # Casts given string value to integer 
    # if possible.
    #
    # Params:
    #
    # var_Name:String - object's name
    #
    # var_Object:Object - string object
    #
    # Returns:SBAInteger
    #
    # Throws:SBATypeError, ArgumentError
    def SBAInteger.fromString(var_Name, var_Object)
      if(!var_Object.instance_of? String)
        raise SBATypeError.new("Incorrect object type [#{var_Object.class}], String expected")
      end
      
      return SBAInteger.new(var_Name, Integer(var_Object))
    end
    
    # Method: to_qres
    #
    # Casts object into QRES::IntegerResult.
    #
    # Params:
    #
    # Returns:QRES::IntegerResult
    #
    # Throws:
    def to_qres()
      return QRES::IntegerResult.new(self.VAR_OBJECT)
    end
      
  end
  
end
