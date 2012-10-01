module QRES

  # Class: BinderResult
  # Extends: AbstractComplexQueryResult
  # 
  # Class represents query result as a binder
  class BinderResult < AbstractComplexQueryResult

    # Method: initialize
    # 
    # Initializes new binder results
    # 
    # Params:
    # var_Name - binder name
    # var_Object - object to bind
    def initialize(var_Name, var_Object)
      if(var_Name == nil || !var_Name.is_a?(String))
        raise ArgumentError.new("Binder name expected")
      end
      
      @VAR_NAME = var_Name
         
      super(var_Object)
    end

    # Method: push
    #
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

    # Method: pop
    #
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

    # Method: equals
    #
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
    
    # Method: to_s
    #
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
