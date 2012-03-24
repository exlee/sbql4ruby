module SBAStore
  
require "lib/SBAStore/SBASimpleObject"
require "lib/Common/exceptions"

require "lib/QRES/StringResult"


  # class SBAString
  # extends SBASimpleObject
  #
  # SBA store Integer class 
  class SBAString < SBASimpleObject
    
    # Method: initialize (constructor)
    #
    # Params:
    #
    # var_Name:String - SBA store object name
    #
    # var_Object:String - SBA store object
    #
    # var_ID:String - SBA object identifier
    #
    # Returns:
    #
    # Throws:SBATypeError
    def initialize(var_Name, var_Object, var_ID=nil)
      if(!SBAString.isValidType?(var_Object))
        raise SBATypeError.new("Incorrect object type [#{var_Object.class}]")
      end
      
      super(var_Name, var_Object, var_ID)
    end
    
    # Static Method: isValidType?
    # 
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

    # Static method: fromString
    #
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
    
    # Method: to_qres
    # 
    # Casts object into QRES::StringResult.
    #
    # Params:
    #
    # Returns:QRES::StringResult
    #
    # Throws:
    def to_qres()
      return QRES::StringResult.new(self.VAR_OBJECT)
    end
    
  end

end
