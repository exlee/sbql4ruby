module QRES

require "lib/SBAStore/SBAString"
require "lib/QRES/AbstractSimpleQueryResult"


  # Class: StringResult
  # Extends: AbstractSimpleQueryResult
  # 
  # Class implements query result representation for String datatype
  class StringResult < AbstractSimpleQueryResult
 
    # Method: initialize (constructor)
    # 
    # Method initializes new StringResult object
    # 
    # Params:
    # var_Object - object to be transformed into StringResult
    # 
    # Throws:
    # QRESTypeError - when object is not castable into StringResult
    def initialize(var_Object)
      if(!SBAStore::SBAString.isValidType?(var_Object))
        raise QRESTypeError.new("Incorrect object type [#{var_Object.class}], " + String.to_s() + " expected")
      end

      super(var_Object)
    end
    
    # Method: dereference
    #
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

    # Method: + (overloaded addition)
    #
    # Overloaded operator adds the StringResult encapsulated values
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
        return StringResult.new(self.VAR_OBJECT + var_RValue.VAR_OBJECT())
      elsif(var_RValue.is_a?(IntegerResult) || var_RValue.is_a?(FloatResult))
        return StringResult.new(self.VAR_OBJECT + var_RValue.VAR_OBJECT().to_s())
      else
        raise SyntaxError.new("[#{self.class.to_s()}] can't be coerced into [#{var_RValue.class.to_s()}]")
      end
    end   
    
    # Method: - (overloaded substraction)
    #
    # Overloaded operator 'minus' is not allowed for StringResult.
    #
    # Params:
    #
    # var_RValue:AbstractQueryResult - QRES object
    #
    # Returns:AbstractSimpleQueryResult
    #
    # Throws:IncorrectArgumentException    
    def -(var_RValue)
      Common::Logger.print(Common::VAR_DEBUG, self, "[-]: Executing for: [#{self.to_s()}] - [#{var_RValue.to_s()}]")
        
      raise SyntaxError.new("[#{var_RValue.class.to_s()}] can't be coerced into [#{self.class.to_s()}] ")
    end 
    
    # Method: * (overloaded multiplication)
    # Overloaded operator 'multiply' is not allowed for StringResult.
    #
    # Params:
    #
    # var_RValue:AbstractQueryResult - QRES object
    #
    # Returns:AbstractSimpleQueryResult
    #
    # Throws:IncorrectArgumentException    
    def *(var_RValue)
      Common::Logger.print(Common::VAR_DEBUG, self, "[*]: Executing for: [#{self.to_s()}] * [#{var_RValue.to_s()}]")
        
      raise SyntaxError.new("[#{var_RValue.class.to_s()}] can't be coerced into [#{self.class.to_s()}] ")
    end
    
    # Method: / (overloaded division)
    #
    # Overloaded operator 'division' is not allowed for StringResult.
    #
    # Params:
    #
    # var_RValue:AbstractQueryResult - QRES object
    #
    # Returns:AbstractSimpleQueryResult
    #
    # Throws:IncorrectArgumentException    
     def /(var_RValue)
       Common::Logger.print(Common::VAR_DEBUG, self, "[/]: Executing for: [#{self.to_s()}] / [#{var_RValue.to_s()}]")

       raise SyntaxError.new("[#{var_RValue.class.to_s()}] can't be coerced into [#{self.class.to_s()}] ")
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
       
       if(var_RValue.is_a?(self.class))
         return self.VAR_OBJECT == var_RValue.VAR_OBJECT()
       else
         raise SyntaxError.new("[#{var_RValue.class.to_s()}] can't be coerced into [#{self.class.to_s()}]")
       end

       raise SyntaxError.new("[#{var_RValue.class.to_s()}] can't be coerced into [#{self.class.to_s()}] ")
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

       if(var_RValue.is_a?(self.class))
         return self.VAR_OBJECT.size() > var_RValue.VAR_OBJECT().size()
       else
         raise SyntaxError.new("[#{var_RValue.class.to_s()}] can't be coerced into [#{self.class.to_s()}]")
       end

       raise SyntaxError.new("[#{var_RValue.class.to_s()}] can't be coerced into [#{self.class.to_s()}] ")
     end
     
     # Method: >= (overloaded greater-equal)
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

       if(var_RValue.is_a?(self.class))
         return self.VAR_OBJECT.size() >= var_RValue.VAR_OBJECT().size()
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

       if(var_RValue.is_a?(self.class))
         return self.VAR_OBJECT.size() < var_RValue.VAR_OBJECT().size()
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

       if(var_RValue.is_a?(self.class))
         return self.VAR_OBJECT.size() <= var_RValue.VAR_OBJECT().size()
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

       if(var_RValue.is_a?(self.class))
         return self.VAR_OBJECT.size() != var_RValue.VAR_OBJECT().size()
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
     # Returns:
     #
     # Throws:SyntaxError    
     def %(var_RValue)
       Common::Logger.print(Common::VAR_DEBUG, self, "[%]: Executing for: [#{self.to_s()}] % [#{var_RValue.to_s()}]")

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
      return SBAStore::SBAString.new(nil, self.VAR_OBJECT())
    end
  end
end
