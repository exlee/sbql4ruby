module SBAStore
  
require "lib/Common/Iterator"


  # Extends iterator class for SBA complex objects.
  class SBAComplexObjectIterator < Common::Iterator
  
    # Params:
    #
    # var_SBAObject:SBAComplexObject - SBA complex object
    #
    # Returns:
    #
    # Throws:
    def initialize(var_SBAObject)
      
      if(!var_SBAObject.is_a?(SBAComplexObject))
        raise IncorrectArgumentError("Incorrect object type [#{var_Object.class}], " + SBAComplexObject.to_s() + " expected")
      end
      
      super(var_SBAObject.VAR_OBJECT)
    end
    
  end
  
end