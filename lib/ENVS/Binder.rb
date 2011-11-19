module ENVS

  class Binder
   
    def initialize(var_Name, var_Value)
      
      if(var_Name == nil || var_Value == nil)
        raise ENVSIncorrectArgumentException.new("Object name and value expected")
      end
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[initialize]: Initialisation for arguments [#{var_Name}], counter [#{var_Value.to_s()}]")
       
      @VAR_NAME = var_Name
      @VAR_VALUE = var_Value
    end
    
    # Returns a string representation of Binder object.
    #
    # Params:
    #
    # Returns:String
    #
    # Throws:
    def to_s()
      return "Name=[#{@VAR_NAME}], Value=[#{@VAR_VALUE.to_s()}, Type=[#{@VAR_VALUE.class.to_s()}]]"
    end
        
    # VAR_NAME:String - object name  
    attr_reader :VAR_NAME
    
    # VAR_VALUE:AbstractQueryResult - QRES object 
    attr_reader :VAR_VALUE
        
  end
  
end