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
      
      # Method: is_numeric?
      #
      # Checks if object is numeric and can be used in numeric operations
      #
      # Params:
      #
      # Returns:Boolean
      #
      # Throws:
      def is_numeric?
        return self.is_a?(IntegerResult) || self.is_a?(FloatResult)
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
  
#        puts "EEE-being: Who ami: #{self.to_s()}"
         
        tmpObject = Utils::bagResultProxy(self)
        
        if(tmpObject.is_a?(BagResult))
          if(tmpObject.VAR_OBJECT.size == 1)
            tmpObject = Utils::getBagResultAsSimpleObject(tmpObject)
          end
        elsif(tmpObject.is_a?(StructResult))
          if(tmpObject.VAR_OBJECT.size == 1)
            tmpObject = Utils::getStructResultAsSimpleObject(tmpObject)
          end
        end
        
#      puts "EEE-being: after conv: #{tmpObject.class.to_s()}, #{tmpObject.to_s()}"
       
        if(tmpObject.is_a?(ReferenceResult))
          result = Utils::dereference(tmpObject, var_Store)
 
          if(result.is_a?(AbstractSetQueryResult))
            str = ""  
            for i in 0..result.VAR_OBJECT.VAR_STACK.size()-1
              if(i!=0)
                str += ","
              end  
              str += result.VAR_OBJECT.get(i).print(var_Store)
            end
            str += ""
          else
            return result.print(var_Store)
          end
             
#       puts "EEE-rr-after: #{str.to_s()}"
        
          return str
        elsif(tmpObject.is_a?(BinderResult))
          return "(#{tmpObject.VAR_OBJECT.print(var_Store)}) as #{tmpObject.VAR_NAME}"
        elsif(tmpObject.is_a?(AbstractSimpleQueryResult))
          return tmpObject.VAR_OBJECT.to_s()
        elsif(tmpObject.is_a?(AbstractSetQueryResult))
          if(tmpObject.VAR_OBJECT.size() == 0)
            return ""
          end
          
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
