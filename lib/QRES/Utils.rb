module QRES
 
require "lib/QRES/AbstractSimpleQueryResult"
 
  
  # Class: Utils
  #
  # Utilitary class with various static methods
  class Utils
  
    # Static Method: isRubyNumericType?
    #
    # Checks given object's type. Returns true
    # if it's Ruby simple object type.
    #
    # Params:
    #
    # var_ObjectName:AbstractQueryResult - QRES object
    #
    # Returns:TrueClass/FalseClass
    #
    # Throws:    
    def Utils::isRubyNumericType?(var_Object)
      if(var_Object.is_a?(Fixnum) || var_Object.is_a?(Float) || var_Object.is_a?(Bignum))
        return true
      end

      return false
    end
    
    # Checks given object's type. Returns true
    # if it's QRES number.
    #
    # Params:
    #
    # var_ObjectName:AbstractQueryResult - QRES object
    #
    # Returns:TrueClass/FalseClass
    #
    # Throws:    
    def Utils::isQRESNumericType?(var_Object)
      if(var_Object.is_a?(IntegerResult) || var_Object.is_a?(FloatResult))
        return true
      end

      return false
    end
    
    # Checks given object's type. Returns true
    # if it's QRES or Ruby number.
    #
    # Params:
    #
    # var_ObjectName:AbstractQueryResult - QRES object
    #
    # Returns:TrueClass/FalseClass
    #
    # Throws:    
    def Utils::isNumericType?(var_Object)
      if(Utils::isQRESNumericType?(var_Object) || Utils::isRubyNumericType?(var_Object))
        return true
      end

      return false
    end
      
    # Checks given object's type. Returns true
    # if it's AbstractSimpleQueryResult or
    # BagResult which provides one object.
    #
    # Params:
    #
    # var_ObjectName:AbstractQueryResult - QRES object
    #
    # Returns:TrueClass/FalseClass
    #
    # Throws:    
    def Utils::isSimpleObject?(var_Object)
      if(var_Object.is_a?(AbstractSimpleQueryResult))
        return true
      elsif(Utils::isBagResult?(var_Object))
        if(var_Object.isSimpleObject?())
          return true
        end
      end

      return false
    end
    
    # StaticMethod: isBagResult?
    #
    # Checks given object's type. Returns true
    # if it's BagResult.
    #
    # Params:
    #
    # var_ObjectName:AbstractQueryResult - QRES object
    #
    # Returns:TrueClass/FalseClass
    #
    # Throws:    
    def Utils::isBagResult?(var_Object)
      if(var_Object.is_a?(BagResult))
        return true
      end

      return false
    end
    
    # Checks given object's type. Returns true
    # if it's StructResult.
    #
    # Params:
    #
    # var_ObjectName:AbstractQueryResult - QRES object
    #
    # Returns:TrueClass/FalseClass
    #
    # Throws:    
    def Utils::isStructResult?(var_Object)
      if(var_Object.is_a?(StructResult))
        return true
      end

      return false
    end
    
    # Gets an object provided by BagResult treated as QRES 
    # simple object (BagResult must provide exactly one simple 
    # object).
    #
    # Params:
    #
    # var_Object:BagResult - QRES object
    #
    # Returns:AbstractQueryResult
    #
    # Throws:    
    def Utils::getBagResultAsSimpleObject(var_Object)
      if(!var_Object.is_a?(BagResult))
        return var_Object
      end

      return var_Object.getAsSimpleResult()
    end
    
    # Static Method: getSimpleObjectAsBagResult
    #
    # Puts given object into new BagResult.
    #
    # Params:
    #
    # var_Object:AbstractSimpleQueryResult - QRES simple object
    #
    # Returns:BagResult
    #
    # Throws:    
    def Utils::getSimpleObjectAsBagResult(var_Object)
      if(!var_Object.is_a?(AbstractSimpleQueryResult))
        return var_Object
      end

      var_Result = BagResult.new()
      var_Result.push(var_Object)
       
      return var_Result
    end
    
    # Static Method: getSimpleObjectAsStructResult
    #
    # Puts given object into new StructResult.
    #
    # Params:
    #
    # var_Object:AbstractSimpleQueryResult - QRES simple object
    #
    # Returns:Structesult
    #
    # Throws:    
    def Utils::getSimpleObjectAsStructResult(var_Object)
      if(!var_Object.is_a?(AbstractSimpleQueryResult))
        return var_Object
      end

      var_Result = StructResult.new()
      var_Result.push(var_Object)
       
      return var_Result
    end    

    # Static Method: isBagQualifiedForProxy
    #
    # This method verifes whether give bag result 
    # provides one struct result object.
    # It qualifies bag proxy method to be used.
    #
    # Params:
    #
    # var_Object:BagResult - QRES object
    #
    # Returns:TrueClass/FalseClass
    #
    # Throws:    
    def Utils::isBagQualifiedForProxy(var_Object)
      
      # Given object has to be BagResult
      if(!var_Object.is_a?(BagResult))
        return false
      end

      # If BagResult provides different number of objects than one
      # we have nothing to do.
      if(var_Object.VAR_OBJECT.size() != 1)
        return false
      end
      
      # If provided object has different type than StructResult
      # we have nothing to do.
      if(!var_Object.VAR_OBJECT.get(0).is_a?(StructResult))
        return false
      end
      
      return true
    end

    # Static Method: bagResultProxy
    #
    # This method treats one element bag result
    # with encapsulated struct result as simple bag
    # result.
    #
    # Params:
    #
    # var_Object:BagResult - QRES object
    #
    # Returns:BagResult
    #
    # Throws:    
    def Utils::bagResultProxy(var_Object)
      
      # Given object has to be BagResult
      if(!var_Object.is_a?(BagResult))
        return var_Object
      end

      # If BagResult provides different number of objects than one
      # we have nothing to do.
      if(var_Object.VAR_OBJECT().size() != 1)
        return var_Object
      end
      
      # If provided object has different type than StructResult
      # we have nothing to do.
      if(!var_Object.VAR_OBJECT.get(0).is_a?(StructResult))
        return var_Object
      end
 
      # One element bag with struct will be treated as bag providing
      # all struct's elements like it's own.
      var_Struct = var_Object.VAR_OBJECT.get(0)
      var_Result = BagResult.new()
      
      for i in 0..var_Struct.VAR_OBJECT.size()-1
        var_Result.push(var_Struct.VAR_OBJECT.get(i))
      end
      
      return var_Result
    end
            
    # Static Method: isSimpleBag
    #
    # This method checks wheather the given bag
    # provides simple QRES objects.
    #
    # Params:
    #
    # var_Object:BagResult - QRES object
    #
    # Returns:TrueClass/FalseClass
    #
    # Throws:    
    def Utils::isSimpleBag?(var_Object)
      
      # Proxy
      if(Utils::isBagQualifiedForProxy(var_Object))
        return true
      end
            
      for i in 0..var_Object.VAR_OBJECT.size()-1
        if(!Utils::isSimpleObject?(var_Object))
          return false
        end
      end
      
      return true
    end
    
    # Static Method: dereference
    #
    # Dereferences given ReferentResult object.
    #
    # Params:
    #
    # var_ObjectName:ReferenceResult - QRES object
    #
    # Returns:AbstractSimpleQueryResult
    #
    # Throws:    
    def Utils::dereference(var_Reference, var_Store)
      if(var_Reference.is_a?(ReferenceResult))
        return var_Reference.dereference(var_Store).to_qres()
      end

      return var_Reference
    end
  end
end
