module QRES

require "lib/SBAStore/SBAFloat"
require "lib/QRES/AbstractSimpleQueryResult"
  

  class FloatResult < AbstractSimpleQueryResult
 
    def initialize(var_Object)
      if(!SBAStore::SBAFloat.isValidType?(var_Object))
        raise QRESTypeError.new("Incorrect object type [#{var_Object.class}], " + Float.to_s() + " expected")
       end

       @VAR_OBJECT = var_Object
     end
      
  end

end