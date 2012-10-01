module QRES

require "lib/SBAStore/SBAFloat"

require "lib/QRES/AbstractSimpleQueryResult"
require "lib/QRES/BooleanResult"

require "lib/QRES/AbstractSimpleQueryResultFactory"
  

  # Class: FloatResult
  # Extends: AbstractSimpleQueryResult
  #
  # Class which implements query result for Float type
  class FloatResult < AbstractSimpleQueryResult
 
    # Method: initialize (constructor)
    # 
    # Creates new FloatResult object based on provided object
    #
    # Params:
    # var_Object
    #
    # Throws:
    # QRESTypeError - when type is incompatible with FloatResult
    def initialize(var_Object)
      if(!SBAStore::SBAFloat.isValidType?(var_Object))
        raise QRESTypeError.new("Incorrect object type [#{var_Object.class}], " + Float.to_s() + " expected")
      end

      super(var_Object)
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

    # Method: - (overloaded substraction)
    #
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
    
    # Method: * (overloaded multiplication)
    #
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
    
    # Method: / (overloaded division)
    #
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
    
    # Method: == (overloaded equal)
    #
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
      end
      
      return false        
    end
    
    # Method: > (overloaded greater than)
    #
    # Overloaded operator 'greater'.
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
    
    # Method: >= (overloaded greater-equal than)
    #
    # Overloaded operator 'greater equal'.
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
    
    # Method: < (overloaded smaller than)
    #
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
    
    # Method: <= (overloaded smaller-equal than)
    #
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
    
    # Method: different
    # 
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
    
    # Method: % (overloaded modulo)
    #
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
   
    # Method: and
    #
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
    
    # Method or
    #
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
      
    # Method to_sba
    #
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
