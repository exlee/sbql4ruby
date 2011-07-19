module SBAStore
  
require "SBASimpleObject"

  # SBA store Integer class 
  class SBAFloat < SBASimpleObject
    
    # Constructor
    #
    # Params:
    #
    # var_Name:String - SBA store object name
    #
    # var_Object:Float - SBA store object
    #
    # Returns: nil
    def initialize(var_Name, var_Object)
      if(!var_Object.is_a? Float)
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
     # Returns: TrueClass/FalseClass
     def isValidType?(var_Object)
       if(var_Object.is_a? Float)
         return true
       end
       
       return false
     end
      
  end

end