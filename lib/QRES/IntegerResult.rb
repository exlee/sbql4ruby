module QRES

require "lib/SBAStore/SBAInteger"

require "lib/QRES/AbstractSimpleQueryResult"
require "lib/QRES/FloatResult"
require "lib/QRES/StringResult"


  # Class: IntegerResult
  # Extends: AbstractSimpleQueryResult
  # 
  # Class which implements representation of query result for Integer datatype
  class IntegerResult < AbstractSimpleQueryResult
 
    # Method: initialize (constructor)
    # 
    # Creates new IntegerResult object
    # 
    # Params:
    # var_Object - object which will be transformed into IntegerResult type
    #
    # Throws:
    # QRESTypeError - in case, when provided type is not castable into IntegerResult
    def initialize(var_Object)
      if(!SBAStore::SBAInteger.isValidType?(var_Object))
        raise QRESTypeError.new("Incorrect object type [#{var_Object.class}], " + Integer.to_s() + " expected")
      end
      
      super(var_Object)
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
      if(var_RValue.is_a?AbstractSetQueryResult and var_RValue.isSimpleObject?)
        var_RValue = var_RValue.getAsSimpleResult()
      end
      
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

    # Method: - (overloaded substraction)
    #
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

    # Method: * (overloaded multiplication)
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
    
    # Method: / (overloaded division)
    #
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
       
      if(var_RValue.is_a?(NilClass))
        return false
      end
      
      if(var_RValue.is_a?(self.class) || var_RValue.is_a?(FloatResult))
        puts "AAA porówanie: #{(self.VAR_OBJECT == var_RValue.VAR_OBJECT()).to_s()}"
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

      if(var_RValue.is_a?(self.class) || var_RValue.is_a?(FloatResult))
        return self.VAR_OBJECT > var_RValue.VAR_OBJECT()
      else
        raise SyntaxError.new("[#{var_RValue.class.to_s()}] can't be coerced into [#{self.class.to_s()}]")
      end
              
      raise SyntaxError.new("[#{var_RValue.class.to_s()}] can't be coerced into [#{self.class.to_s()}] ")
    end
    
    # Method: >= (overloaded greater-equal than)
    #
    # Overloaded operator 'greathr equal'.
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

      if(var_RValue.is_a?(self.class) || var_RValue.is_a?(FloatResult))
        return self.VAR_OBJECT >= var_RValue.VAR_OBJECT()
      else
        raise SyntaxError.new("[#{var_RValue.class.to_s()}] can't be coerced into [#{self.class.to_s()}]")
      end
              
      raise SyntaxError.new("[#{var_RValue.class.to_s()}] can't be coerced into [#{self.class.to_s()}] ")
    end
    
    # Method: < (overloaded operator smaller than)
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

      if(var_RValue.is_a?(self.class) || var_RValue.is_a?(FloatResult))
        return self.VAR_OBJECT < var_RValue.VAR_OBJECT()
      else
        raise SyntaxError.new("[#{var_RValue.class.to_s()}] can't be coerced into [#{self.class.to_s()}]")
      end
              
      raise SyntaxError.new("[#{var_RValue.class.to_s()}] can't be coerced into [#{self.class.to_s()}] ")
    end
    
    # Method: <= (overloaded operator smaller-equal than)
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
      Common::Logger.print(Common::VAR_DEBUG, self, "[>=]: Executing for: [#{self.to_s()}] <= [#{var_RValue.to_s()}]")

      if(var_RValue.is_a?(self.class) || var_RValue.is_a?(FloatResult))
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

      if(var_RValue.is_a?(self.class) || var_RValue.is_a?(FloatResult))
        return self.VAR_OBJECT != var_RValue.VAR_OBJECT()
      else
        raise SyntaxError.new("[#{var_RValue.class.to_s()}] can't be coerced into [#{self.class.to_s()}]")
      end
              
      raise SyntaxError.new("[#{var_RValue.class.to_s()}] can't be coerced into [#{self.class.to_s()}] ")
    end
    
    # Method: % (overloaded operator modulo)
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

      if(var_RValue.is_a?(self.class) || var_RValue.is_a?(FloatResult))
        return FloatResult.new(Float(self.VAR_OBJECT % var_RValue.VAR_OBJECT()))
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
    
    # Method: or
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
            
    # Method: to_sba
    #
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
