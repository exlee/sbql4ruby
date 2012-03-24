module QRES

require "lib/QRES/AbstractMethodException"


  # Class: AbstractQueryResult
  #
  # Abstract class which represents query results
  class AbstractQueryResult
      
      # Method: initialize (constructor)
      # 
      # Creates new AbstractQueryResult
      # ( for use by subclasses )
      def initialize(var_Object)
        @VAR_OBJECT = var_Object
      end
      
      # Method: equals
      #
      # Compares QRES value objects 
      #
      # Params:
      #
      # var_Object:Object - string object
      #
      # Returns:TrueClass/FalseClass
      #
      # Throws:AbstractMethodException
      def equals(var_Object)
        raise AbstractMethodException.new("Abstract method")
      end
      
      # Method: dereference
      #
      # Abstract method to be implemented by inheriting classes.
      #
      # Params:
      #
      # var_Store - SBA store where the current object will be dereferenced
      #
      # Returns:
      #
      # Throws:AbstractMethodException
      def dereference(var_Store)
        raise AbstractMethodException.new("Abstract method")
      end
      
      # Method: to_s
      #
      # Returns a string representation of QRES value object.
      #
      # Params:
      #
      # Returns:String
      #
      # Throws:
      def to_s()
        return "[#{@VAR_OBJECT.class.to_s()}, #{@VAR_OBJECT.to_s()}]"
      end
      
      # VAR_OBJECT:Object - object identifier of the structure of identifires
      attr_reader :VAR_OBJECT
  end

end
