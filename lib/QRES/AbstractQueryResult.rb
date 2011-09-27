module QRES


  class AbstractQueryResult
      
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
      # Throws:SBANotImplementedError
      def equals(var_Object)
        raise SBANotImplementedError.new("Abstract method")
      end
      
      # Returns a string representation of QRES value object.
      #
      # Params:
      #
      # Returns:String
      #
      # Throws:SBANotImplementedError
      def to_s
        raise SBANotImplementedError.new("Abstract method")
      end
      
      # VAR_OBJECT:Object - object identifier of the structure of identifires
      attr_reader :VAR_OBJECT
  end

end