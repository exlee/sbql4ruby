module QRES

require "lib/SBAStore/SBABoolean"
require "lib/QRES/AbstractSimpleQueryResult"
  

  class BooleanResult < AbstractSimpleQueryResult
 
    def initialize(var_Object)
      if(!SBAStore::SBABoolean.isValidType?(var_Object))
        raise QRESTypeError.new("Incorrect object type [#{var_Object.class}], " + TrueClass.to_s() + 
                                "/" + FalseClass.to_s() + " expected")
      end

      super(var_Object)
    end
    
    # Overloaded operator adds the BooleanResult encapsulated values
    # and returns a new AbstractSimpleQueryResult object which provides 
    # result.
    #
    # Params:
    #
    # var_RValue:AbstractQueryResult - QRES object
    #
    # Returns:
    #
    # Throws:IncorrectArgumentException    
    def +(var_RValue)
      Common::Logger.print(Common::VAR_DEBUG, self, "[+]: Executing for: [#{self.to_s()}] + [#{var_RValue.to_s()}]")
        
      raise SyntaxError.new("[#{var_RValue.class.to_s()}] can't be coerced into [#{self.class.to_s()}] ")
    end
    
    # Overloaded operator 'minus' is not allowed for BooleanResult.
    #
    # Params:
    #
    # var_RValue:AbstractQueryResult - QRES object
    #
    # Returns:
    #
    # Throws:IncorrectArgumentException    
    def -(var_RValue)
      Common::Logger.print(Common::VAR_DEBUG, self, "[-]: Executing for: [#{self.to_s()}] - [#{var_RValue.to_s()}]")
        
      raise SyntaxError.new("[#{var_RValue.class.to_s()}] can't be coerced into [#{self.class.to_s()}] ")
    end
    
    # Overloaded operator 'multiply' is not allowed for BooleanResult.
    #
    # Params:
    #
    # var_RValue:AbstractQueryResult - QRES object
    #
    # Returns:
    #
    # Throws:IncorrectArgumentException    
    def *(var_RValue)
      Common::Logger.print(Common::VAR_DEBUG, self, "[*]: Executing for: [#{self.to_s()}] * [#{var_RValue.to_s()}]")
        
      raise SyntaxError.new("[#{var_RValue.class.to_s()}] can't be coerced into [#{self.class.to_s()}] ")
    end
    
    # Overloaded operator 'division' is not allowed for BooleanResult.
    #
    # Params:
    #
    # var_RValue:AbstractQueryResult - QRES object
    #
    # Returns:
    #
    # Throws:IncorrectArgumentException    
    def /(var_RValue)
      Common::Logger.print(Common::VAR_DEBUG, self, "[/]: Executing for: [#{self.to_s()}] / [#{var_RValue.to_s()}]")
        
      raise SyntaxError.new("[#{var_RValue.class.to_s()}] can't be coerced into [#{self.class.to_s()}] ")
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
       
      if(var_RValue.is_a?(self.class))
        return self.VAR_OBJECT == var_RValue.VAR_OBJECT()
      end
      
      return false  
      #raise SyntaxError.new("[#{var_RValue.class.to_s()}] can't be coerced into [#{self.class.to_s()}] ")
    end
    
    # Overloaded operator 'greather' is not allowed for BooleanResult.
    #
    # Params:
    #
    # var_RValue:AbstractQueryResult - QRES object
    #
    # Returns:
    #
    # Throws:IncorrectArgumentException  
    def >(var_RValue)
      Common::Logger.print(Common::VAR_DEBUG, self, "[>]: Executing for: [#{self.to_s()}] > [#{var_RValue.to_s()}]")
        
      raise SyntaxError.new("[#{var_RValue.class.to_s()}] can't be coerced into [#{self.class.to_s()}] ")
    end
    
    # Overloaded operator 'greather equal' is not allowed for BooleanResult.
    #
    # Params:
    #
    # var_RValue:AbstractQueryResult - QRES object
    #
    # Returns:
    #
    # Throws:IncorrectArgumentException  
    def >=(var_RValue)
      Common::Logger.print(Common::VAR_DEBUG, self, "[>=]: Executing for: [#{self.to_s()}] >= [#{var_RValue.to_s()}]")
        
      raise SyntaxError.new("[#{var_RValue.class.to_s()}] can't be coerced into [#{self.class.to_s()}] ")
    end
    
    # Overloaded operator 'less' is not allowed for BooleanResult.
    #
    # Params:
    #
    # var_RValue:AbstractQueryResult - QRES object
    #
    # Returns:
    #
    # Throws:IncorrectArgumentException  
    def <(var_RValue)
      Common::Logger.print(Common::VAR_DEBUG, self, "[<]: Executing for: [#{self.to_s()}] < [#{var_RValue.to_s()}]")
        
      raise SyntaxError.new("[#{var_RValue.class.to_s()}] can't be coerced into [#{self.class.to_s()}] ")
    end
    
    # Overloaded operator 'less equal' is not allowed for BooleanResult.
    #
    # Params:
    #
    # var_RValue:AbstractQueryResult - QRES object
    #
    # Returns:
    #
    # Throws:IncorrectArgumentException  
    def <=(var_RValue)
      Common::Logger.print(Common::VAR_DEBUG, self, "[<=]: Executing for: [#{self.to_s()}] <= [#{var_RValue.to_s()}]")
        
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
 
      if(var_RValue.is_a?(self.class))
        return self.VAR_OBJECT != var_RValue.VAR_OBJECT()
      end
        
      raise SyntaxError.new("[#{var_RValue.class.to_s()}] can't be coerced into [#{self.class.to_s()}] ")
    end       
    
    # Overloaded operator 'modulo'.
    #
    # Params:
    #
    # var_RValue:AbstractQueryResult - QRES object
    #
    # Returns:
    #
    # Throws:SyntaxError    
    def %(var_RValue)
      Common::Logger.print(Common::VAR_DEBUG, self, "[<=]: Executing for: [#{self.to_s()}] <= [#{var_RValue.to_s()}]")
        
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
       
      if(var_RValue.is_a?(self.class))
        return self.VAR_OBJECT && var_RValue.VAR_OBJECT()
      end
        
      raise SyntaxError.new("[#{var_RValue.class.to_s()}] can't be coerced into [#{self.class.to_s()}] ")
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
       
      if(var_RValue.is_a?(self.class))
        return self.VAR_OBJECT || var_RValue.VAR_OBJECT()
      end
        
      raise SyntaxError.new("[#{var_RValue.class.to_s()}] can't be coerced into [#{self.class.to_s()}] ")
    end
        
    # Casts current object value into SBA object.
    #
    # Params:
    #
    # Returns:SBAObject
    #
    # Throws:    
    def to_sba()
      return SBAStore::SBABoolean.new(nil, self.VAR_OBJECT())
    end
  end
end