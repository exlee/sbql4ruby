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