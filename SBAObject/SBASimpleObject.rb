module SBAStore
  
require "SBAObject"

  # SBA store abstract class for simple objects 
  class SBASimpleObject < SBAStore::SBAObject

    # Constructor
    #
    # Params:
    #
    # var_Name:String - SBA store object name
    #
    # var_Object:String || Numeric - SBA store simple data object
    #
    # Returns: nil
    def initialize(var_Name, var_Object)
      if(!isValidType?(var_Object))
        raise TypeError.new("Incorrect object type [#{var_Object.class}]")
      end
      
      super(var_Name, var_Object)
    end
    
     # Validates given object's type
     #
     # Params:
     #
     # var_Object:Object - object to be validated
     #
     # Returns: TrueClass || FalseClass
     def isValidType?(var_Object)
       if((var_Object.is_a? String) || (var_Object.is_a? Numeric))
         return true
       end
       
       return false
      end
      
  end
 
end