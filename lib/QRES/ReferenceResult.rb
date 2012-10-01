module QRES

require "lib/Common/logger"

require "lib/QRES/IntegerResult"
require "lib/QRES/AbstractComplexQueryResult"
require "lib/QRES/IncorrectArgumentException"

require "lib/SBAStore/SBAStore"
  
  
  # Class: ReferenceResult
  # Extends: AbstractComplexQueryResult
  #
  # Implements query result for Reference objects

  class ReferenceResult < AbstractComplexQueryResult
      
    def initialize(var_Identifier)
      if(var_Identifier == nil)
        raise ArgumentError.new("Object identifier expected")
      end

      super(var_Identifier)
    end

    # Method: push
    #
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

    # Method: pop
    #
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

    # Method: equals
    #
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

    # Method: dereference
    #
    # Dereferences current QRES object searching in SBA store.
    #
    # Params:
    #
    # var_Store:SBAStore - SBA store object
    #
    # Returns:SBAObject
    #
    # Throws:IncorrectArgumentException
    def dereference(var_Store)
      if(!var_Store.is_a?(SBAStore::SBAStore))
        raise IncorrectArgumentException.new("Incorrect argument type [#{var_Store.to_s()}] , expected [SBAStore]")
      end      
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[dereference]: Executing in context of current object: [#{self.to_s()}]")  
      
      var_SBAObject = var_Store.find(self.VAR_OBJECT())
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[dereference]: Found [#{var_SBAObject.to_s()}]")
      
      return var_SBAObject
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
      return self.class.to_s() + "(value=" + super() + ")"
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
