module QRES

require "lib/Common/Stack"


  # Class: QRES
  # 
  # Class implements Query Result Stack
  class QRES
    
    # Method: initialize (constructor)
    # 
    # Initializes empty Query Result Stack
    def initialize()
      @VAR_STACK = Common::Stack.new()
    end
    
    # Method: push
    #
    # Push QRES object into the stack 
    #
    # Params:
    #
    # var_Object:AbstractQueryResult - QRES object
    #
    # Returns:
    #
    # Throws:    
    def push(var_Object)
      if(!var_Object.is_a?(AbstractQueryResult))
        raise QRESTypeError.new("Incorrect object type [#{var_Object.class}], " + AbstractQueryResult.to_s() + " expected")
      end
      
      @VAR_STACK.push(var_Object)
    end
    
    # Method: pop
    #
    # Gets QRES object from the stack 
    #
    # Params:
    #
    # Returns:AbstractQueryResult
    #
    # Throws:
    def pop()
      return @VAR_STACK.pop()
    end
    
    # Method: to_s
    #
    # Returns a string representation of QRES object.
    #
    # Params:
    #
    # Returns:String
    #
    # Throws:
    def to_s()
      return self.class.to_s() + @VAR_STACK.to_s()
    end
      
    # Alias for push method.
    #
    # Params:
    #
    # var_Object:AbstractQueryResult - QRES object
    #
    # Returns:
    #
    # Throws:
    alias add push
    
    # VAR_STACK:Array - QRES stack  
    attr_reader :VAR_STACK
  
  end
  
end
