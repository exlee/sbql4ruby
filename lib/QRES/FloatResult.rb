module QRES

require "lib/SBAStore/SBAFloat"

require "lib/QRES/AbstractSimpleQueryResult"
require "lib/QRES/BooleanResult"

require "lib/QRES/AbstractSimpleQueryResultFactory"
  

  class FloatResult < AbstractSimpleQueryResult
 
    def initialize(var_Object)
      if(!SBAStore::SBAFloat.isValidType?(var_Object))
        raise QRESTypeError.new("Incorrect object type [#{var_Object.class}], " + Float.to_s() + " expected")
      end

      super(var_Object)
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
    
    # Overloaded operator adds the FloatResult encapsulated values
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
        
      if(var_RValue.is_a?(self.class) || var_RValue.is_a?(IntegerResult))
        return FloatResult.new(self.VAR_OBJECT + var_RValue.VAR_OBJECT())
      elsif(var_RValue.is_a?(StringResult))
        return StringResult.new(self.VAR_OBJECT.to_s() + var_RValue.VAR_OBJECT())
      else
        raise SyntaxError.new("[#{var_RValue.class.to_s()}] can't be coerced into [#{self.class.to_s()}]")
      end
    end

    # Overloaded operator subtracts the FloatResult encapsulated values
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
        
      if(var_RValue.is_a?(self.class) || var_RValue.is_a?(IntegerResult))
        return FloatResult.new(self.VAR_OBJECT - var_RValue.VAR_OBJECT())
      else
        raise SyntaxError.new("[#{var_RValue.class.to_s()}] can't be coerced into [#{self.class.to_s()}]")
      end
    end
    
    # Overloaded operator multiplies the FloatResult encapsulated values
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
        
      if(var_RValue.is_a?(self.class) || var_RValue.is_a?(IntegerResult))
        return FloatResult.new(self.VAR_OBJECT * var_RValue.VAR_OBJECT())
      else
        raise SyntaxError.new("[#{var_RValue.class.to_s()}] can't be coerced into [#{self.class.to_s()}]")
      end
    end
    
    # Overloaded operator divides the FloatResult encapsulated values
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
        
      if(var_RValue.is_a?(self.class) || var_RValue.is_a?(IntegerResult))
        return FloatResult.new(self.VAR_OBJECT / var_RValue.VAR_OBJECT())
      else
        raise SyntaxError.new("[#{var_RValue.class.to_s()}] can't be coerced into [#{self.class.to_s()}]")
      end
    end
    
    # Overloaded operator 'equal'.
    #
    # Params:
    #
    # var_RValue:AbstractQueryResult - QRES object
    #
    # Returns:TrueClass/FalseClass
    #
    # Throws:SyntaxError    
    def ==(var_RValue)
      Common::Logger.print(Common::VAR_DEBUG, self, "[==]: Executing for: [#{self.to_s()}] == [#{var_RValue.to_s()}]")

      # Overloaded 'equal' operator returns BooleanResult, but Ruby 'not equal' operator uses 'equal' operator 
      # expecting TrueClass/FalseClass result. In this case it's impossible to compare FloatResult with nil 
      # in proper way. Following implementation of nil support allows comparison like this: 
      # foo<FloatResult> != nil and foo<FloatResult> == nil.
      if(var_RValue.is_a?(NilClass))
        return false
      end
      
      if(var_RValue.is_a?(self.class) || var_RValue.is_a?(IntegerResult))
        return self.VAR_OBJECT == var_RValue.VAR_OBJECT()
      else
        raise SyntaxError.new("[#{var_RValue.class.to_s()}] can't be coerced into [#{self.class.to_s()}]")
      end
              
      raise SyntaxError.new("[#{var_RValue.class.to_s()}] can't be coerced into [#{self.class.to_s()}] ")
    end
    
    # Overloaded operator 'greather'.
    #
    # Params:
    #
    # var_RValue:AbstractQueryResult - QRES object
    #
    # Returns:TrueClass/FalseClass
    #
    # Throws:SyntaxError    
    def >(var_RValue)
      Common::Logger.print(Common::VAR_DEBUG, self, "[>]: Executing for: [#{self.to_s()}] > [#{var_RValue.to_s()}]")

      if(var_RValue.is_a?(self.class) || var_RValue.is_a?(IntegerResult))
        return self.VAR_OBJECT > var_RValue.VAR_OBJECT()
      else
        raise SyntaxError.new("[#{var_RValue.class.to_s()}] can't be coerced into [#{self.class.to_s()}]")
      end
              
      raise SyntaxError.new("[#{var_RValue.class.to_s()}] can't be coerced into [#{self.class.to_s()}] ")
    end
    
    # Overloaded operator 'greather equal'.
    #
    # Params:
    #
    # var_RValue:AbstractQueryResult - QRES object
    #
    # Returns:TrueClass/FalseClass
    #
    # Throws:SyntaxError    
    def >=(var_RValue)
      Common::Logger.print(Common::VAR_DEBUG, self, "[>=]: Executing for: [#{self.to_s()}] >= [#{var_RValue.to_s()}]")

      if(var_RValue.is_a?(self.class) || var_RValue.is_a?(IntegerResult))
        return self.VAR_OBJECT >= var_RValue.VAR_OBJECT()
      else
        raise SyntaxError.new("[#{var_RValue.class.to_s()}] can't be coerced into [#{self.class.to_s()}]")
      end
              
      raise SyntaxError.new("[#{var_RValue.class.to_s()}] can't be coerced into [#{self.class.to_s()}] ")
    end
    
    # Overloaded operator 'less'.
    #
    # Params:
    #
    # var_RValue:AbstractQueryResult - QRES object
    #
    # Returns:TrueClass/FalseClass
    #
    # Throws:SyntaxError    
    def <(var_RValue)
      Common::Logger.print(Common::VAR_DEBUG, self, "[<]: Executing for: [#{self.to_s()}] < [#{var_RValue.to_s()}]")

      if(var_RValue.is_a?(self.class) || var_RValue.is_a?(IntegerResult))
        return self.VAR_OBJECT < var_RValue.VAR_OBJECT()
      else
        raise SyntaxError.new("[#{var_RValue.class.to_s()}] can't be coerced into [#{self.class.to_s()}]")
      end
              
      raise SyntaxError.new("[#{var_RValue.class.to_s()}] can't be coerced into [#{self.class.to_s()}] ")
    end
    
    # Overloaded operator 'less equal'.
    #
    # Params:
    #
    # var_RValue:AbstractQueryResult - QRES object
    #
    # Returns:TrueClass/FalseClass
    #
    # Throws:SyntaxError    
    def <=(var_RValue)
      Common::Logger.print(Common::VAR_DEBUG, self, "[<=]: Executing for: [#{self.to_s()}] <= [#{var_RValue.to_s()}]")

      if(var_RValue.is_a?(self.class) || var_RValue.is_a?(IntegerResult))
        return self.VAR_OBJECT <= var_RValue.VAR_OBJECT()
      else
        raise SyntaxError.new("[#{var_RValue.class.to_s()}] can't be coerced into [#{self.class.to_s()}]")
      end
              
      raise SyntaxError.new("[#{var_RValue.class.to_s()}] can't be coerced into [#{self.class.to_s()}] ")
    end
    
    # Overloaded operator 'different'.
    #
    # Params:
    #
    # var_RValue:AbstractQueryResult - QRES object
    #
    # Returns:TrueClass/FalseClass
    #
    # Throws:SyntaxError    
    def different(var_RValue)
      Common::Logger.print(Common::VAR_DEBUG, self, "[!=]: Executing for: [#{self.to_s()}] != [#{var_RValue.to_s()}]")

      if(var_RValue.is_a?(self.class) || var_RValue.is_a?(IntegerResult))
        return self.VAR_OBJECT != var_RValue.VAR_OBJECT()
      else
        raise SyntaxError.new("[#{var_RValue.class.to_s()}] can't be coerced into [#{self.class.to_s()}]")
      end
              
      raise SyntaxError.new("[#{var_RValue.class.to_s()}] can't be coerced into [#{self.class.to_s()}] ")
    end
    
    # Overloaded operator 'modulo'.
    #
    # Params:
    #
    # var_RValue:AbstractQueryResult - QRES object
    #
    # Returns:AbstractSimpleQueryResult
    #
    # Throws:SyntaxError    
    def %(var_RValue)
      Common::Logger.print(Common::VAR_DEBUG, self, "[%]: Executing for: [#{self.to_s()}] % [#{var_RValue.to_s()}]")

      if(var_RValue.is_a?(self.class) || var_RValue.is_a?(IntegerResult))
        return FloatResult.new(self.VAR_OBJECT % var_RValue.VAR_OBJECT())
      else
        raise SyntaxError.new("[#{var_RValue.class.to_s()}] can't be coerced into [#{self.class.to_s()}]")
      end
              
      raise SyntaxError.new("[#{var_RValue.class.to_s()}] can't be coerced into [#{self.class.to_s()}] ")
    end
   
    # Overloaded operator 'and'.
    #
    # Params:
    #
    # var_RValue:AbstractQueryResult - QRES object
    #
    # Returns:TrueClass/FalseClass
    #
    # Throws:SyntaxError    
    def and(var_RValue)
      Common::Logger.print(Common::VAR_DEBUG, self, "[&&]: Executing for: [#{self.to_s()}] && [#{var_RValue.to_s()}]")
       
      return self.VAR_OBJECT && var_RValue.VAR_OBJECT()
    end
    
    # Overloaded operator 'or'.
    #
    # Params:
    #
    # var_RValue:AbstractQueryResult - QRES object
    #
    # Returns:TrueClass/FalseClass
    #
    # Throws:SyntaxError    
    def or(var_RValue)
      Common::Logger.print(Common::VAR_DEBUG, self, "[||]: Executing for: [#{self.to_s()}] || [#{var_RValue.to_s()}]")
       
      return self.VAR_OBJECT || var_RValue.VAR_OBJECT()
    end   
      
    # Casts current object value into SBA object.
    #
    # Params:
    #
    # Returns:SBAObject
    #
    # Throws:    
    def to_sba()
      return SBAStore::SBAFloat.new(nil, self.VAR_OBJECT())
    end
  end
end