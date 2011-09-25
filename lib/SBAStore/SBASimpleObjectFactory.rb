module SBAStore
  
require "lib/Common/exceptions"
require "lib/SBAStore/SBAInteger"
require "lib/SBAStore/SBAFloat"
require "lib/SBAStore/SBABoolean"
require "lib/SBAStore/SBAString"


  class SBASimpleObjectFactory
    
    # Verifies given simple object type and
    # creates a new SBA object depending
    # on the verify result.
    #
    # Params:
    #
    # var_Name:String - SBA store object name
    #
    # var_Object:String - SBA store object
    #
    # Returns:SBAObject
    #
    # Throws:SBATypeError
    def SBASimpleObjectFactory.create(var_Name, var_Object) 
     
      var_Tmp = nil
       
      #Integer
      SBASimpleObjectFactory.ignore_exceptions(SBATypeError, ArgumentError) do var_Tmp = SBAInteger.fromString(var_Name, var_Object) end
      
      if(var_Tmp != nil)
         return var_Tmp
      end
      
      #Float
      SBASimpleObjectFactory.ignore_exceptions(SBATypeError, ArgumentError) do var_Tmp = SBAFloat.fromString(var_Name, var_Object) end
      
      if(var_Tmp != nil)
        return var_Tmp
      end
        
      #Boolean (TrueClass/FalseClass)
      SBASimpleObjectFactory.ignore_exceptions(SBATypeError, ArgumentError) do var_Tmp = SBABoolean.fromString(var_Name, var_Object) end
        
      if(var_Tmp != nil)
        return var_Tmp
      end
        
      #String
      SBASimpleObjectFactory.ignore_exceptions(SBATypeError, ArgumentError) do var_Tmp = SBAString.fromString(var_Name, var_Object) end
      
      if(var_Tmp != nil)
        return var_Tmp
      end     
       
      #Not supported type
      if(var_Tmp == nil)
        raise SBATypeError.new(self.to_s() + "Incorrect object type [#{var_Object.class}]")        
      end 

    end
    
    # Executes given code and ignores specified exceptions.
    #
    # Params:
    #
    # var_Exceptions:String - exceptions to be ignored
    #
    # Returns:
    #
    # Throws:    
    def SBASimpleObjectFactory.ignore_exceptions(*var_Exceptions)
       yield
     rescue *var_Exceptions => e
       Common::Logger.print(Common::VAR_DEBUG, self, "Ignored exception [#{e}]")
    end
    
    # Verifies given object type and returns 
    # true if it's an instance of object
    # that is suppotrted by the SBAObject.
    #
    # Params:
    #
    # var_Object:Object - Object to be verified
    #
    # Returns:TrueClass/FalseClass
    #
    # Throws:
    def SBASimpleObjectFactory.isValidType?(var_Object) 
      if( SBAInteger.isValidType?(var_Object)  ||
          SBAFloat.isValidType?(var_Object)    ||
          SBABoolean.isValidType?(var_Object)  ||
          SBAString.isValidType?(var_Object) )
        return true
      end
      
      return false
    end
    
    # Method:SBASimpleObjectFactory.isValidSBAType?
    #
    # Verifies given object type and returns 
    # true if it's an instance of SBAObject.
    #
    # Params:
    #
    # var_Object:SBAOBject - SBA object to be verified
    #
    # Returns:TrueClass/FalseClass
    #
    # Throws:
    def SBASimpleObjectFactory.isValidSBAType?(var_Object) 
      if( var_Object.is_a?(SBAInteger) ||
          var_Object.is_a?(SBAFloat)   ||
          var_Object.is_a?(SBABoolean) ||
          var_Object.is_a?(SBAString) )
        return true
      end
      
      return false
    end
      
  end
  
end