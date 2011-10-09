module Common
  
  
  class Stack

    def initialize()
      @VAR_STACK = []
    end

    # Puts given object into the stack 
    #
    # Params:
    #
    # var_Object:AbstractQueryResult - QRES model object
    #
    # Returns:
    #
    # Throws:
    def push(var_Object)
      @VAR_STACK.push(var_Object)
    end

    # Gest first object from the top of the stack 
    #
    # Params:
    #
    # Returns:AbstractQueryResult
    #
    # Throws:
    def pop()
      @VAR_STACK.pop()
    end

    # Returns the number of objects kept by the stack 
    #
    # Params:
    #
    # Returns:Fixnum
    #
    # Throws:
    def size()
      @VAR_STACK.length()
    end
    
    # Removes all objects from the stack 
    #
    # Params:
    #
    # Returns:
    #
    # Throws:    
    def clear()
      @VAR_STACK.clear()
    end

    # Returns the last object in the stack
    #
    # Params:
    #
    # Returns:AbstractQueryResult
    #
    # Throws:
    def last()
      @VAR_STACK.last()
    end
    
    # Returns an object kept by the stack by the given array index 
    #
    # Params:
    #
    # Returns:AbstractQueryResult
    #
    # Throws:
    def get(var_Counter)
      return @VAR_STACK[var_Counter]
    end
    
    # Compares two stacks (length and all kept QRES objects one by one)
    #
    # Params:
    #
    # Returns:FrueClass/FalseClass
    #
    # Throws:   
    def equals(var_Object)
      if(@VAR_STACK.length != var_Object.size())
        return false
      end
      
      for i in (0...@VAR_STACK.length)
        if(!@VAR_STACK[i] == var_Object.get(i))
          return false
        end
      end
      
      return true
    end

    # Returns a string representation of Stack object.
    #
    # Params:
    #
    # Returns:String
    #
    # Throws:
    def to_s()
      var_Message = "Stack: "
      
      for i in (0...@VAR_STACK.length-1)
        if(i==0)
          var_Message += "index=[" + i.to_s() + "] value=[" + @VAR_STACK[i].to_s() + "]"  
        else
          var_Message += ", index=[" + i.to_s() + "] value=[" + @VAR_STACK[i].to_s() + "]"     
        end 
      end
      
      return var_Message
    end
        
  end
  
end