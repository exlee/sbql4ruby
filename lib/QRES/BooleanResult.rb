module QRES

require "lib/SBAStore/SBABoolean"
require "lib/QRES/AbstractSimpleQueryResult"
  

  class BooleanResult < AbstractSimpleQueryResult
 
    def initialize(var_Object)
      if(!SBAStore::SBAFloat.isValidType?(var_Object))
        raise QRESTypeError.new("Incorrect object type [#{var_Object.class}], " + TrueClass.to_s() + 
                                "/" + FalseClass.to_s() + " expected")
      end

      super(var_Object)
     end
       
  end

end