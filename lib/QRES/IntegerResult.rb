module QRES

require "lib/SBAStore/SBAInteger"

require "lib/QRES/AbstractSimpleQueryResult"
require "lib/QRES/FloatResult"
require "lib/QRES/StringResult"


  class IntegerResult < AbstractSimpleQueryResult
 
    def initialize(var_Object)
      if(!SBAStore::SBAInteger.isValidType?(var_Object))
        raise QRESTypeError.new("Incorrect object type [#{var_Object.class}], " + Integer.to_s() + " expected")
      end
      
      super(var_Object)
    end
    
    # Dereferences current QRES object searching in SBA store.
    #
    # Params:
    #
    # var_Store - SBA store where the current object will be dereferenced
    #
    # Returns:
    #
    # Throws:
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

    # Overloaded operator adds the IntegerResult encapsulated values
    # and returns a new AbstractSimpleQueryResult object which provides 
    # result.
    #
    # Params:
    #
    # var_RValue:AbstractQueryResult - QRES object
    #
    # Returns:AbstractSimpleQueryResult
    #
    # Throws:SyntaxError    
    def +(var_RValue)
      Common::Logger.print(Common::VAR_DEBUG, self, "[+]: Executing for: [#{self.to_s()}] + [#{var_RValue.to_s()}]")
        
      if(var_RValue.is_a?(self.class))
        return IntegerResult.new(self.VAR_OBJECT + var_RValue.VAR_OBJECT())
      elsif(var_RValue.is_a?(FloatResult))
        return FloatResult.new(self.VAR_OBJECT + var_RValue.VAR_OBJECT())
      elsif(var_RValue.is_a?(StringResult))
        return StringResult.new(self.VAR_OBJECT.to_s() + var_RValue.VAR_OBJECT())
      else
        raise SyntaxError.new("[#{var_RValue.class.to_s()}] can't be coerced into [#{self.class.to_s()}]")
      end
    end

    # Overloaded operator subtracts the IntegerResult encapsulated values
    # and returns a new AbstractSimpleQueryResult object which provides 
    # result.
    #
    # Params:
    #
    # var_RValue:AbstractQueryResult - QRES object
    #
    # Returns:AbstractSimpleQueryResult
    #
    # Throws:SyntaxError    
    def -(var_RValue)
      Common::Logger.print(Common::VAR_DEBUG, self, "[-]: Executing for: [#{self.to_s()}] - [#{var_RValue.to_s()}]")
        
      if(var_RValue.is_a?(self.class))
        return IntegerResult.new(self.VAR_OBJECT - var_RValue.VAR_OBJECT())
      elsif(var_RValue.is_a?(FloatResult))
        return FloatResult.new(self.VAR_OBJECT - var_RValue.VAR_OBJECT())
      else
        raise SyntaxError.new("[#{var_RValue.class.to_s()}] can't be coerced into [#{self.class.to_s()}]")
      end
    end

    # Overloaded operator multiplies the IntegerResult encapsulated values
    # and returns a new AbstractSimpleQueryResult object which provides 
    # result.
    #
    # Params:
    #
    # var_RValue:AbstractQueryResult - QRES object
    #
    # Returns:AbstractSimpleQueryResult
    #
    # Throws:SyntaxError    
    def *(var_RValue)
      Common::Logger.print(Common::VAR_DEBUG, self, "[*]: Executing for: [#{self.to_s()}] * [#{var_RValue.to_s()}]")
        
      if(var_RValue.is_a?(self.class))
        return IntegerResult.new(self.VAR_OBJECT * var_RValue.VAR_OBJECT())
      elsif(var_RValue.is_a?(FloatResult))
        return FloatResult.new(self.VAR_OBJECT * var_RValue.VAR_OBJECT())
      else
        raise SyntaxError.new("[#{var_RValue.class.to_s()}] can't be coerced into [#{self.class.to_s()}]")
      end
    end
    
    # Overloaded operator divides the IntegerResult encapsulated values
    # and returns a new AbstractSimpleQueryResult object which provides 
    # result.
    #
    # Params:
    #
    # var_RValue:AbstractQueryResult - QRES object
    #
    # Returns:AbstractSimpleQueryResult
    #
    # Throws:SyntaxError    
    def /(var_RValue)
      Common::Logger.print(Common::VAR_DEBUG, self, "[/]: Executing for: [#{self.to_s()}] / [#{var_RValue.to_s()}]")
        
      if(var_RValue.is_a?(self.class) || (var_RValue.is_a?(FloatResult)))
        if((self.VAR_OBJECT % var_RValue.VAR_OBJECT()) > 0)
          return FloatResult.new(self.VAR_OBJECT / var_RValue.VAR_OBJECT())
        else
          return IntegerResult.new(self.VAR_OBJECT / var_RValue.VAR_OBJECT())
        end
      else
        raise SyntaxError.new("[#{var_RValue.class.to_s()}] can't be coerced into [#{self.class.to_s()}]")
      end
    end
            
    # Casts current object value into SBA object.
    #
    # Params:
    #
    # Returns:SBAObject
    #
    # Throws:    
    def to_sba()
      return SBAStore::SBAInteger.new(nil, self.VAR_OBJECT())
    end
  end
end