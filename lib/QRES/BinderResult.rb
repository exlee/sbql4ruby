module QRES

  class BinderResult < AbstractComplexQueryResult

    def initialize(var_Name, var_Object)
      if(var_Name == nil || !var_Name.is_a?(String))
        raise ArgumentError.new("Binder name expected")
      end
      
      @VAR_NAME = var_Name
         
      super(var_Object)
    end

    # Pushes a pair (name and object) to the binder object 
    #
    # Params:
    #
    # var_Name:String - object name
    #
    # var_Object:AbstractQueryResult - QRES object
    #
    # Returns:
    #
    # Throws:    
    def push(var_Name, var_Object)
      if(var_Name == nil)
        raise ArgumentError.new("Binder name expected")
      end
       
      self.VAR_OBJECT = var_Object
    end

    # Returns kept object   
    #
    # Params:
    #
    # Returns:
    #
    # Throws:    
    def pop()
      return self.VAR_OBJECT
    end

    # Compares QRES value objects 
    #
    # Params:
    #
    # var_Object:BinderResult
    #
    # Returns:TrueClass/FalseClass
    #
    # Throws:
    def equals(var_Object)
      if(var_Object.is_a?(BinderResult))
        return super(var_Object)
      end
      
      raise QRESTypeError.new("Incorrect object type [#{var_Object.class}], " + BinderResult.to_s() + " expected")
    end
    
    # Returns a string representation of QRES value object.
    #
    # Params:
    #
    # Returns:String
    #
    # Throws:
    def to_s()
      return self.class.to_s() + "(name=" + @VAR_NAME + ", value=" + super() + ")"
    end
      
    # Alias for push method.
    #
    # Params:
    #
    # var_Name:String - object name
    #
    # var_Object:AbstractQueryResult - QRES object
    #
    # Returns:
    #
    # Throws:
    alias add push
    
    # VAR_NAME:String - SBA store object name
    attr_reader :VAR_NAME
    
  end

end