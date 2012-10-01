module QRES
  
  # Class: AbstractSimpleQueryResultFactory
  # 
  # Abstract class which represents SimpleQueryResult factory
  class AbstractSimpleQueryResultFactory
  
    # Static Method: create
    # Verifies given simple object type and
    # creates a new QRES object depending
    # on the verify result.
    #
    # Params:
    #
    # var_Object:String - SBA store object
    #
    # Returns:AbstractSimpleQueryResult
    #
    # Throws:SBATypeError
    def AbstractSimpleQueryResultFactory.create(var_Object)
      
      var_Tmp = nil
      
      #Integer
      AbstractSimpleQueryResultFactory.ignore_exceptions(QRESTypeError) do var_Tmp = IntegerResult.new(var_Object) end
      
      if(var_Tmp != nil)
         return var_Tmp
      end
      
      #Float
      AbstractSimpleQueryResultFactory.ignore_exceptions(QRESTypeError) do var_Tmp = FloatResult.new(var_Object) end
             
      if(var_Tmp != nil)
        return var_Tmp
      end
        
      #Boolean (TrueClass/FalseClass)
      AbstractSimpleQueryResultFactory.ignore_exceptions(QRESTypeError) do var_Tmp = BooleanResult.new(var_Object) end
        
      if(var_Tmp != nil)
        return var_Tmp
      end
        
      #String
      AbstractSimpleQueryResultFactory.ignore_exceptions(QRESTypeError) do var_Tmp = StringResult.new(var_Object) end
      
      if(var_Tmp != nil)
        return var_Tmp
      end     
       
      #Not supported type
      if(var_Tmp == nil)
        raise NotSupportedTypeException.new(self.to_s() + "Incorrect object type [#{var_Object.class.to_s()}]")        
      end
    end
    
    # Static Method: ignore_exceptions
    #
    # Executes given code and ignores specified exceptions.
    #
    # Params:
    #
    # var_Exceptions:String - exceptions to be ignored
    #
    # Returns:
    #
    # Throws:    
    def AbstractSimpleQueryResultFactory.ignore_exceptions(*var_Exceptions)
       yield
     rescue *var_Exceptions => e
       Common::Logger.print(Common::VAR_DEBUG, self, "Ignored exception [#{e}]")
    end
  end
end
