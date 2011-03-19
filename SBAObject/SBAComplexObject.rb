module SBAStore
  
require "SBAObject"

  # SBA store abstract class for simple objects 
  class SBAComplexObject < SBAStore::SBAObject

    # Constructor
    #
    # Params:
    #
    # var_Name:String - SBA store object name
    #
    # var_Object:Object - SBA store complex data object
    #
    # Returns: nil
    def initialize(var_Name, var_Object)
      super(var_Name, var_Object)
    end
    
     # Abstract method, should be implemented by the inheriting 
     # classes (valids given object)
     #
     # Params:
     #
     # var_Object:Object - object to be validated
     #
     # Returns: TrueClass || FalseClass
     def isValidType?(var_Object)
       raise NotImplementedError.new("Abstract method")
     end
      
  end
  
end