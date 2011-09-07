module SBAStore

require "SBASimpleObject"
require "exceptions"


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
      
  end

end