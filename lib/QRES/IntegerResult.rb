module QRES

require "lib/SBAStore/SBAInteger"
require "lib/QRES/AbstractSimpleQueryResult"


  class IntegerResult < AbstractSimpleQueryResult
 
    def initialize(var_Object)
      if(!SBAStore::SBAInteger.isValidType?(var_Object))
        raise QRESTypeError.new("Incorrect object type [#{var_Object.class}], " + Integer.to_s() + " expected")
      end
      
      @VAR_OBJECT = var_Object
    end
    
  end

end