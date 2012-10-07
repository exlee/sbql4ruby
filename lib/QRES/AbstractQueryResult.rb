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
      
      # Method: to_s
      #
      # Returns a printable string representation of QRES value object.
      #
      # Params:
      #
      # Returns:String
      #
      # Throws:
      def print(var_Store)
        tmpObject = Utils::bagResultProxy(self)
        
        if(tmpObject.is_a?(ReferenceResult))
          return (Utils::dereference(tmpObject, var_Store)).VAR_OBJECT
        elsif(self.is_a?(AbstractSimpleQueryResult))
          return @VAR_OBJECT.to_s()
        elsif(self.is_a?(AbstractSetQueryResult))  
          if(tmpObject.is_a?(BagResult))
            str = "bag("
          else
            str = "struct("
          end
          
          for i in 0..tmpObject.VAR_OBJECT.VAR_STACK.size()-1
            object = tmpObject.VAR_OBJECT.get(i)
             
            if(i!=0)
             str += ","
            end
            str += object.print(var_Store)  
          end

          str += ")" 
          return str
        end  
      end
      
      # VAR_OBJECT:Object - object identifier of the structure of identifires
      attr_reader :VAR_OBJECT
  end

end
