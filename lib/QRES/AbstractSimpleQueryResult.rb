module QRES

require "lib/QRES/AbstractQueryResult"
require "lib/QRES/AbstractMethodException"


  # Class: AbstractSimpleQueryResult
  # Extends: AbstractQueryResult
  # 
  # Abstract class which represents simple-typed query results
  class AbstractSimpleQueryResult < AbstractQueryResult
      
    # Method: initialize (constructor)
    # 
    # Initializes new AbstractSimpleQueryResult
    # ( for use in subclasses )
    def initialize(var_Object)
      super(var_Object)
    end
      
    # Method: equals
    #
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
    
    # Method: + (overloaded addition)
    #
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

    # Method: - (overloaded substraction)
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

    # Method: * (overloaded multiplication)
    # 
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
    
    # Method: / (overloaded division)
    #
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
    
    # Method: == (overloaded equal)
    #
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
    
    # Method: to_sba
    #
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
