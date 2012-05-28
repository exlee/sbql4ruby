module QRES

require "lib/Common/NestedIterator"
require "lib/Common/exceptions"


  # Extends NestedIterator class for BagResult objects.
  class BagResultNestedIterator < Common::NestedIterator
    
    # Params:
    #
    # var_BagResult:BagResult - BagResult object
    #
    # Returns:
    #
    # Throws:
    def initialize(var_BagResult)
      
      if(!var_BagResult.is_a?(BagResult))
        raise IncorrectArgumentError.new("Incorrect object type [#{var_Object.class}], " + BagResult.to_s() + " expected")
      end
      
      super(var_BagResult.VAR_OBJECT().VAR_STACK())
    end 
  end
  
end