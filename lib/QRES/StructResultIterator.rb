module QRES

require "lib/Common/Iterator"
require "lib/QRES/StructResult"

require "lib/Common/exceptions"


  # Class: StructResultIterator
  # Extends: Common::Iterator
  #
  # Extends iterator class for BagResult objects.
  class StructResultIterator < Common::Iterator
    
    # Method: initialize (constructor)
    #
    # Params:
    #
    # var_BagResult:StructResult - StructResult object
    #
    # Returns:
    #
    # Throws:
    def initialize(var_StructResult)
      
      if(!var_StructResult.is_a?(StructResult))
        raise IncorrectArgumentError.new("Incorrect object type [#{var_Object.class}], " + StructResult.to_s() + " expected")
      end
      
      super(var_StructResult.VAR_OBJECT().VAR_STACK())
    end 
  end
  
end
