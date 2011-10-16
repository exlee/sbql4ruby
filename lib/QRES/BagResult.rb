module QRES

require "lib/Common/Stack"


  class BagResult < AbstractComplexQueryResult
    
    def initialize()
      super(Common::Stack.new())
    end

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
      
      # Pushing BagResult to another BagResult
      if(var_Object.is_a?(BagResult))
        for i in 0..var_Object.VAR_OBJECT.size()-1
          self.VAR_OBJECT.push(var_Object.VAR_OBJECT.get(i))
        end
      else
        self.VAR_OBJECT.push(var_Object)
      end
    end

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

    # Compares QRES value objects 
    #
    # Params:
    #
    # var_Object:BagResult
    #
    # Returns:TrueClass/FalseClass
    #
    # Throws:
    def equals(var_Object)
      if(var_Object.is_a?(BagResult))
        return super(var_Object)
      end
      
      raise QRESTypeError.new("Incorrect object type [#{var_Object.class}], " + BagResult.to_s() + " expected")
    end
    
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