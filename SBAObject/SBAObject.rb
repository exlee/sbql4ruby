module SBAStore

  # SBA store basic abstract class 
  class SBAObject

    # VAR_OBJECT_COUNTER:Integer - SBAObject instances counter
    @@VAR_OBJECT_COUNTER = 0
    
    # Constructor
    #
    # Params:
    #
    # var_Name:String - SBA store object name
    #
    # var_Object:Object - SBA store encapsulated object
    #
    # Returns: nil
    def initialize(var_Name, var_Object)
      @VAR_ID = @@VAR_OBJECT_COUNTER
      @VAR_NAME = var_Name
      @VAR_OBJECT = var_Object
      
      @@VAR_OBJECT_COUNTER += 1
    end

     # Gets SBAObjects instance counter
     #
     # Params:
     #
     # var_Name:String - SBA store object name
     #
     # Returns: VAR_OBJECT_COUNTER:INTEGER
    def VAR_OBJECT_COUNTER
      @@VAR_OBJECT_COUNTER
    end
    
    # VAR_ID:Integer - SBA store object identifier
    attr :VAR_ID
    
    # VAR_NAME:String - SBA store object name
    attr :VAR_NAME
    
    # VAR_OBJECT:Object - SBA store encapsulated object
    attr :VAR_OBJECT
         
  end
end
