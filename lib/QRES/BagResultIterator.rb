module QRES

require "lib/Common/Iterator"
require "lib/QRES/BagResult"


  # Extends iterator class for BagResult objects.
  class BagResultIterator < Common::Iterator
    
    # Params:
    #
    # var_BagResult:BagResult - BagResult object
    #
    # Returns:
    #
    # Throws:
    def initialize(var_BagResult)
      
      if(!var_BagResult.is_a?(BagResult))
        raise IncorrectArgumentError("Incorrect object type [#{var_Object.class}], " + BagResult.to_s() + " expected")
      end
      
      super(var_BagResult.VAR_OBJECT)
    end 
  end
  
end