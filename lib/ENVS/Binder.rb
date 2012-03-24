module ENVS

  # Class: Binder
  # 
  # Binds object with provided name
  class Binder
   
    # Method: initialize (constructor)
    # 
    # Initializes object using name and value
    # 
    # Params:
    # var_name - Name for which bind happens
    # var_value - Object for which bind happens
    # 
    # Throws:
    # ENVSIncorrectArgumentException (when name or value not supplied)

    def initialize(var_Name, var_Value)
      
      if(var_Name == nil || var_Value == nil)
        raise ENVSIncorrectArgumentException.new("Object name and value expected")
      end
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[initialize]: Initialisation for arguments [#{var_Name}], counter [#{var_Value.to_s()}]")
       
      @VAR_NAME = var_Name
      @VAR_VALUE = var_Value
    end
    
    # Method: to_s
    #
    # Returns a string representation of Binder object.
    #
    # Params:
    #
    # Returns:String
    #
    # Throws:
    def to_s()
      return "ContainerName=[#{@VAR_NAME}], ContainerType=[#{self.class.to_s()}], DataValue=[#{@VAR_VALUE.to_s()}]"
    end
        
    # VAR_NAME:String - object name  
    attr_reader :VAR_NAME
    
    # VAR_VALUE:AbstractQueryResult - QRES object 
    attr_reader :VAR_VALUE
        
  end
  
end
