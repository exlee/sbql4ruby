module QRES

require "lib/Common/Stack"
require "lib/QRES/Utils"
require "lib/QRES/AbstractQueryResult"


  # Class: AbstractComplexQueryResult
  # Extends: AbstractQueryResult
  # 
  # Abstract class for comple query results
  class AbstractComplexQueryResult < AbstractQueryResult
      
      # Method: initialize (constructor)
      # 
      # Initializes new AbstractComplexQueryResult
      # (for use in sub objects)
      def initialize(var_Object)
        #if(!var_Object.is_a?(Common::Stack))
        #  raise QRESTypeError.new("Incorrect object type [#{var_Object.class}], " + Common::Stack.to_s() + " expected")
        #end
          
        super(var_Object)
      end
      
      # Method: push
      #
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

      # Method: pop
      #
      # Abstract method, gets QRES object from BagResult   
      #
      # Params:
      #
      # Returns:AbstractQueryResult
      #
      # Throws:    
      def pop()
       raise AbstractMethodException.new("Abstract method")
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
      # Throws:
      def equals(var_Object)
        return self.VAR_OBJECT.equals(var_Object.VAR_OBJECT)
      end    
      
      # Abstract method, finds QRES objects 
      #
      # Params:
      #
      # var_Object:AbstractSimpleQueryResult - QRES object
      #
      # Returns:BagResult
      #
      # Throws:AbstractMethodException    
      def is_contained?(var_Object)
        raise AbstractMethodException.new("Abstract method")
      end
  end
end
