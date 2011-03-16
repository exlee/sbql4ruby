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
    # Returns: nil
    def initialize(var_Name)
      @VAR_ID = @@VAR_OBJECT_COUNTER
      @VAR_NAME = var_Name
      
      @@VAR_OBJECT_COUNTER += 1
    end

     # Gets SBAObjects instances counter
     #
     # Params:
     #
     # var_Name:String - SBA store object name
     #
     # Returns: nil
    def VAR_OBJECT_COUNTER
      @@VAR_OBJECT_COUNTER
    end
    
    # VAR_ID:Integer - SBA store object identifier
    attr :VAR_ID
    
     # VAR_NAME:String - SBA store object name
    attr :VAR_NAME
         
  end
 
end
