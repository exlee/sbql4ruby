module QRES

require "lib/QRES/IntegerResult"
  
  
  class ReferenceResult < AbstractComplexQueryResult
      
    def initialize(var_Identifier))
      if(var_Identifier == nil)
        raise ArgumentError.new("Object identifier expected")
      end

      super(var_Identifier)
    end

    # Pushes object's identifier
    #
    # Params:
    #
    # var_Object:AbstractQueryResult - QRES object
    #
    # Returns:
    #
    # Throws:    
    def push(var_Identifier)
      if(var_Identifier == nil)
        raise ArgumentError.new("Object identifier expected")
      end

      self.VAR_OBJECT = var_Identifier
    end

    # Returns kept object   
    #
    # Params:
    #
    # Returns:AbstractQueryResult
    #
    # Throws:    
    def pop()
      return self.VAR_OBJECT
    end

    # Compares QRES value objects 
    #
    # Params:
    #
    # var_Object:ReferenceResult
    #
    # Returns:TrueClass/FalseClass
    #
    # Throws:
    def equals(var_Object)
      if(var_Object.is_a?(ReferenceResult))
        return super(var_Object)
      end
      
      raise QRESTypeError.new("Incorrect object type [#{var_Object.class}], " + ReferenceResult.to_s() + " expected")
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
    
    # Alias for push method
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