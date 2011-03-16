module SBAObject

  # An abstract class for SBAStore 
  class SBAObject
  
    # Parameters: var_Id, var_Name
    def initiaize(var_Id, var_Name)
      @VAR_ID = var_Id
      @VAR_NAME = var_Name
    end
  
    # Getter method for SBAStore object identifier
    # Returns: VAR_ID
    def VAR_ID
      @VAR_ID
    end
  
    def VAR_NAME
      @VAR_NAME
    end
    
  end
   
end