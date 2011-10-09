module QRES

require "lib/Common/Stack"


  class AbstractComplexQueryResult < AbstractQueryResult
      
      def initialize(var_Object)
        if(!var_Object.is_a?(Common::Stack))
          raise QRESTypeError.new("Incorrect object type [#{var_Object.class}], " + Common::Stack.to_s() + " expected")
        end
          
        super(var_Object)
      end
      
      # Abstract method, pushes QRES object into BagResult 
      #
      # Params:
      #
      # var_Object:AbstractQueryResult - QRES object
      #
      # Returns:
      #
      # Throws:AbstractMethodException    
      def push(var_Object)
        raise AbstractMethodException.new("Abstract method")
      end

      # Abstract methid, gets QRES object from BagResult   
      #
      # Params:
      #
      # Returns:AbstractQueryResult
      #
      # Throws:    
      def pop()
       raise AbstractMethodException.new("Abstract method")
      end
      
      # Compares QRES value objects 
      #
      # Params:
      #
      # var_Object:Object - string object
      #
      # Returns:TrueClass/FalseClass
      #
      # Throws:
      def equals(var_Object)
        if(!var_Object.is_a?(QRES::BagResult))
          raise QRESTypeError.new("Incorrect object type [#{var_Object.class}], " + QRES::BagResult.to_s() + " expected")
        end
        
        return self.VAR_OBJECT.equals(var_Object.VAR_OBJECT)
      end
        
  end

end