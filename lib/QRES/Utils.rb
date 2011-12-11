module QRES
 
require "lib/QRES/AbstractSimpleQueryResult"
require "lib/QRES/BagResult"
 
  
  class Utils
    
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
    
    # Gets an object provided by BagResult treated as QRES 
    # simple object (BagResult must provide exactly one simple 
    # object).
    #
    # Params:
    #
    # var_ObjectName:BagResult - QRES object
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
  end
end