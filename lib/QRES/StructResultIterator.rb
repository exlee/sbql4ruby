module QRES

require "lib/Common/Iterator"
require "lib/QRES/StructResult"


  # Extends iterator class for BagResult objects.
  class StructResultIterator < Common::Iterator
    
    # Params:
    #
    # var_BagResult:StructResult - StructResult object
    #
    # Returns:
    #
    # Throws:
    def initialize(var_StructResult)
      
      if(!var_StructResult.is_a?(StructResult))
        raise IncorrectArgumentError("Incorrect object type [#{var_Object.class}], " + StructResult.to_s() + " expected")
      end
      
      super(var_StructResult.VAR_OBJECT)
    end 
  end
  
end