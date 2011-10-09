module QRES


  class AbstractSimpleQueryResult < AbstractQueryResult
      
      def initialize(var_Object)
        super(var_Object)
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
        if(!var_Object.is_a?(AbstractSimpleQueryResult))
          raise QRESTypeError.new("Incorrect object type [#{var_Object.class}], AbstractSimpleQueryResult expected")
        end
        
        if(var_Object.VAR_OBJECT == self.VAR_OBJECT)
          return true
        end
        
        return false
      end
        
  end

end