module SBAStore
  
require "lib/SBAStore/SBASimpleObject"
require "lib/Common/exceptions"


  # SBA store Integer class 
  class SBAFloat < SBASimpleObject
    
    # Params:
    #
    # var_Name:String - SBA store object name
    #
    # var_Object:Float - SBA store object
    #
    # var_ID:String - SBA object identifier
    #
    # Returns:
    #
    # Throws:SBATypeError
    def initialize(var_Name, var_Object, var_ID=nil)
     if(!SBAFloat.isValidType?(var_Object))
        raise SBATypeError.new("Incorrect object type [#{var_Object.class}]")
      end
      
      super(var_Name, var_Object, var_ID)
    end

    # Validates given object's type.
    #
    # Params:
    #
    # var_Object:Object - object to be validated
    #
    # Returns:TrueClass/FalseClass
    #
    # Throws:
    def SBAFloat.isValidType?(var_Object)
      if(var_Object.is_a? Float)  
        return true
      end
       
      return false
    end
     
    # Casts given string value to float 
    # if possible.
    #
    # Params:
    #
    # var_Name:String - object's name
    # var_Object:Object - string object
    #
    # Returns:SBAFloat
    #
    # Throws:SBATypeError, ArgumentError
    def SBAFloat.fromString(var_Name, var_Object)
      if(!var_Object.instance_of? String)
        raise SBATypeError.new("Incorrect object type [#{var_Object.class}], String expected")
      end
      
      return SBAFloat.new(var_Name, Float(var_Object))
    end      
  end

end