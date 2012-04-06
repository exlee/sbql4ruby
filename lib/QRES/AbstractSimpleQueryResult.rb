module QRES

require "lib/QRES/AbstractQueryResult"
require "lib/QRES/AbstractMethodException"


  class AbstractSimpleQueryResult < AbstractQueryResult
      
    def initialize(var_Object)
      super(var_Object)
    end
      
    # Compares QRES value objects 
    #
    # Params:
    #
    # var_Object:Object - string object
    #
    # Returns:TrueClass/FalseClass
    #
    # Throws:QRESTypeError
    def equals(var_Object)
      if(!var_Object.is_a?(AbstractSimpleQueryResult))
        raise QRESTypeError.new("Incorrect object type [#{var_Object.class}], AbstractSimpleQueryResult expected")
      end
        
      if(var_Object.VAR_OBJECT == self.VAR_OBJECT)
        return true
      end
        
      return false
    end
    
    # Abstract method to be implemented by inheriting classes.
    #
    # Params:
    #
    # var_RValue:AbstractQueryResult - QRES object
    #
    # Returns:AbstractSimpleQueryResult
    #
    # Throws:AbstractMethodExcepion    
    def +(var_RValue)
      raise AbstractMethodException.new("Abstract method")
    end

    # Abstract method to be implemented by inheriting classes.
    #
    # Params:
    #
    # var_RValue:AbstractQueryResult - QRES object
    #
    # Returns:AbstractSimpleQueryResult
    #
    # Throws:AbstractMethodExcepion    
    def -(var_RValue)
      raise AbstractMethodException.new("Abstract method")     
    end

    # Abstract method to be implemented by inheriting classes.
    #
    # Params:
    #
    # var_RValue:AbstractQueryResult - QRES object
    #
    # Returns:AbstractSimpleQueryResult
    #
    # Throws:AbstractMethodExcepion    
    def *(var_RValue)
      raise AbstractMethodException.new("Abstract method")       
    end
    
    # Abstract method to be implemented by inheriting classes.
    #
    # Params:
    #
    # var_RValue:AbstractQueryResult - QRES object
    #
    # Returns:AbstractSimpleQueryResult
    #
    # Throws:AbstractMethodExcepion    
    def /(var_RValue)
      raise AbstractMethodException.new("Abstract method")  
    end
    
    # Abstract method to be implemented by inheriting classes.
    #
    # Params:
    #
    # var_RValue:AbstractQueryResult - QRES object
    #
    # Returns:TrueClass/FalseClass
    #
    # Throws:AbstractMethodExcepion    
    def ==(var_RValue)
      raise AbstractMethodException.new("Abstract method")  
    end
        
    # Abstract method to be implemented by inheriting classes.
    #
    # Params:
    #
    # Returns:
    #
    # Throws:AbstractMethodExcepion    
    def to_sba()
      raise AbstractMethodExcepion.new("Abstract method")
    end  
  end
end