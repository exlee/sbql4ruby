module SBAStore

require "lib/SBAStore/SBASimpleObject"
require "lib/Common/exceptions"


  # SBA store Integer class 
  class SBABoolean < SBASimpleObject
    
    # Method:initialize
    #
    # Params:
    #
    # var_Name:String - SBA store object name
    # var_Object:TrueClass || FalseClass - SBA store object
    #
    # Returns:
    #
    # Throws:SBATypeError
    def initialize(var_Name, var_Object)
      if(!SBABoolean.isValidType?(var_Object))
        raise SBATypeError.new("Incorrect object type [#{var_Object.class}]")
      end
      
      super(var_Name, var_Object)
    end

     # Method:SBABoolean.isValidType?
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
     def SBABoolean.isValidType?(var_Object)
       if((var_Object.is_a? TrueClass) || (var_Object.is_a? FalseClass))
         return true
       end
       
       return false
     end
     
     # Method:SBABoolean.fromString
     #
     # Casts given string value to TrueClass/FalseClass 
     # if possible
     #
     # Params:
     #
     # var_Name:String - object's name
     # var_Object:Object - string object
     #
     # Returns:SBABoolean
     #
     # Throws:SBATypeError, ArgumentError
     def SBABoolean.fromString(var_Name, var_Object)
       if(!var_Object.instance_of? String)
         raise SBATypeError.new("Incorrect object type [#{var_Object.class}], String expected")
       end
       
       if(var_Object == true.to_s())
         return SBABoolean.new(var_Name, true);
       elsif(var_Object == false.to_s())
         return SBABoolean.new(var_Name, false);
       end
       
       raise ArgumentError.new("invalid value for TrueClass/FalseClass: " + var_Object);
     end
      
  end

end