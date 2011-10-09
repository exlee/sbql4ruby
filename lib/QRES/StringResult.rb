module QRES

require "lib/SBAStore/SBAString"
require "lib/QRES/AbstractSimpleQueryResult"


  class StringResult < AbstractSimpleQueryResult
 
    def initialize(var_Object)
      if(!SBAStore::SBAString.isValidType?(var_Object))
        raise QRESTypeError.new("Incorrect object type [#{var_Object.class}], " + String.to_s() + " expected")
      end

      super(var_Object)
    end
      
  end

end