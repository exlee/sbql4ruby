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
    
    # Dereferences current QRES object searching in SBA store.
    #
    # Params:
    #
    # var_Store - SBA store where the current object will be dereferenced
    #
    # Returns:AbstractSimpleQueryResult
    #
    # Throws:IncorrectArgumentException
    def dereference(var_Store)
      if(!var_Store.is_a?(SBAStore::SBAStore))
        raise IncorrectArgumentException("Incorrect argument type [#{var_Store.class.to_s()}], expected [SBAStore]")
      end
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[dereference]: Executing in context of current object: [#{self.to_s()}], stacks dump:")
      Common::Logger.print(Common::VAR_DEBUG, self, "[dereference]: #{@VAR_QRES.to_s()}\n#{@VAR_ENVS.to_s()}")
      
      var_SBAObject = nil
      
      if(self.VAR_NAME == nil)
        var_SBAObject = self.to_sba()
      else
        var_SBAObject = var_Store.find(self.VAR_OBJECT())
      end
       
      Common::Logger.print(Common::VAR_DEBUG, self, "[dereference]: Found [#{var_SBAObject.to_s()}]")
       
      return var_SBAObject
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
    
    # Abstract method to be implemented by inheriting classes.
    #
    # Params:
    #
    # var_RValue:AbstractQueryResult - QRES object
    #
    # Returns:TrueClass/FalseClass
    #
    # Throws:AbstractMethodExcepion    
    def >(var_RValue)
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
    def >=(var_RValue)
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
    def <(var_RValue)
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
    def <=(var_RValue)
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
    def %(var_RValue)
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
    def and(var_RValue)
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
    def or(var_RValue)
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
    def different(var_RValue)
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
