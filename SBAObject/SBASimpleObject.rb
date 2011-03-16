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
    # var_Object:Object - SBA store data object
    #
    # Returns: nil
    def initialize(var_Name, var_Object)
      super(var_Name)

      @VAR_OBJECT = var_Object
    end
  
    # VAR_ID:Object - SBA store object identifier
    attr :VAR_OBJECT
    
  end
 
end