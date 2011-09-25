module SBAStore
  
require "lib/SBAStore/SBASimpleObject"
require "lib/Common/exceptions"

  # SBA store Integer class 
  class SBAString < SBASimpleObject
    
    # Params:
    #
    # var_Name:String - SBA store object name
    # var_Object:String - SBA store object
    #
    # Returns:
    #
    # Throws:SBATypeError
    def initialize(var_Name, var_Object)
      if(!SBAString.isValidType?(var_Object))
        raise SBATypeError.new("Incorrect object type [#{var_Object.class}]")
      end
      
      super(var_Name, var_Object)
    end
    
    # Validates given object's type. 
    #
    # Params:
    #
    # var_Object:Object - object to be validated
    #
    # Returns: TrueClass/FalseClass
    #
    # Throws:
    def SBAString.isValidType?(var_Object)
      if((var_Object.is_a? String))
        return true
      end
       
      return false
    end

    # Verifies whether given object 
    # has a String type and returns 
    # this object if true.
    #
    # Params:
    #
    # var_Name:String - object's name
    #
    # var_Object:Object - string object
    #
    # Returns:String
    #
    # Throws:SBATypeError, ArgumentError
    def SBAString.fromString(var_Name, var_Object)
      if(!var_Object.instance_of? String)
        raise SBATypeError.new("Incorrect object type [#{var_Object.class}], String expected")
      end

      return SBAString.new(var_Name, var_Object)
    end
    
  end

end