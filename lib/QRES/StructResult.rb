module QRES

require "lib/QRES/StructResultIterator"


  # Class: StructResult
  # Extends: AbstractComplexQueryResult
  #
  # Implements query result for Struct object
  class StructResult < AbstractComplexQueryResult
    
    # Method: initialize (constructor)
    # 
    # Initializes new StructResult object
    def initialize()
      super(Common::Stack.new())
    end

    # Method: push
    #
    # Push QRES object into BagResult 
    #
    # Params:
    #
    # var_Object:AbstractQueryResult - QRES object
    #
    # Returns:
    #
    # Throws:    
    def push(var_Object)
      
      # Pushing BagResult or StructResult to another StructResult
      if(var_Object.is_a?(BagResult) || var_Object.is_a?(StructResult))
        for i in 0..var_Object.VAR_OBJECT.size()-1
          self.VAR_OBJECT.push(var_Object.VAR_OBJECT.get(i))
        end
      else
        self.VAR_OBJECT.push(var_Object)
      end
    end

    # Method: pop
    #
    # Gets QRES object from BagResult 
    #
    # Params:
    #
    # Returns:AbstractQueryResult
    #
    # Throws:    
    def pop()
      return self.VAR_OBJECT.pop()
    end

    # Method: equals
    # Compares QRES value objects 
    #
    # Params:
    #
    # var_Object:StructResult
    #
    # Returns:TrueClass/FalseClass
    #
    # Throws:
    def equals(var_Object)
      if(var_Object.is_a?(StructResult))
        return super(var_Object)
      end

      raise QRESTypeError.new("Incorrect object type [#{var_Object.class}], " + StructResult.to_s() + " expected")
    end

    # Method: iterator
    #
    # Returns iterator.
    #
    # Params:
    #
    # Returns:StructResultIterator
    #
    # Throws:
    def iterator()
      return StructResultIterator.new(self)
    end
         
    # Method: to_s
    # Returns a string representation of QRES value object.
    #
    # Params:
    #
    # Returns:String
    #
    # Throws:
    def to_s()
      return self.class.to_s() + super()
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
          
  end

end
