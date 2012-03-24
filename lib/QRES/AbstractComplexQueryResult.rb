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
      
      # Method: wheres
      #
      # Evaluates 'wheres' function 
      #
      # Params:
      #
      # var_RValue:AbstractSimpleQueryResult - QRES simple object
      #
      # Returns:BagResult
      #
      # Throws:
      def wheres(var_RValue, var_AST)
        
        Common::Logger.print(Common::VAR_DEBUG, self, "[wheres]: Calling perator on the object #{self.to_s()}")
        
        bagResult = BagResult.new()
        
        bagIterator = self.iterator()
         
        while(bagIterator.hasNext())
          object = bagIterator.next()

          Common::Logger.print(Common::VAR_DEBUG, self, "[wheres]: Calling nested for object type [#{object.class.to_s()}], data [#{object.to_s()}]")
          Common::Logger.print(Common::VAR_DEBUG, self, "[wheres]: #{var_AST.VAR_QRES().to_s()}\n#{var_AST.VAR_ENVS().to_s()}")

          # Nested for the given object
          var_AST.VAR_ENVS().nested(object, var_AST.VAR_STORE())

          # Executing the right side of query
          var_RValue.execute(var_AST)

          # Taking query result from QRES stack
          expressionResult = var_AST.VAR_QRES().pop()

          # If result is not a simple query result throw an exception, otherwise compare with left side condition
          if(!Utils.isSimpleObject?(expressionResult))
            raise RuntimeError.new("Incorrect object type [#{result.class.to_s()}]") 
          end
          
          expressionResult = Utils::getBagResultAsSimpleObject(Utils::dereference(expressionResult, var_AST.VAR_STORE()))  
          
          if(expressionResult.VAR_OBJECT == true)
            bagResult.push(object)
          end
          
          # Removing the last frame from ENVS stack
          var_AST.VAR_ENVS().pop()

          Common::Logger.print(Common::VAR_DEBUG, self, "[wheres]: Expression results: #{bagResult.to_s()}")
          Common::Logger.print(Common::VAR_DEBUG, self, "[wheres]: #{var_AST.VAR_QRES().to_s()}\n#{var_AST.VAR_ENVS().to_s()}")
        end
          
        return bagResult
      end 
      
      # Method: comma
      #
      # Evaluates 'comma' function 
      #
      # Params:
      #
      # var_RValue:AbstractSimpleQueryResult - QRES simple object
      #
      # Returns:BagResult
      #
      # Throws:
      def comma(var_RValue, var_AST)
        
        Common::Logger.print(Common::VAR_DEBUG, self, "[comma]: Calling operator on the object #{self.to_s()}")
        
        bagResult = BagResult.new()
        
        # Evaluating the right side of the expression
        var_RValue.execute(var_AST)

        Common::Logger.print(Common::VAR_DEBUG, self, "[comma]: rValue is executed, stacks dump:")
        Common::Logger.print(Common::VAR_DEBUG, self, "[comma]: #{var_AST.VAR_QRES().to_s()}\n#{var_AST.VAR_ENVS().to_s()}")
        
        rValue =  Utils.getSimpleObjectAsBagResult(var_AST.VAR_QRES().pop())
            
        leftIterator = self.iterator()
        
        Common::Logger.print(Common::VAR_DEBUG, self, "[comma]: lValue iterator: #{leftIterator.to_s()}")
         
        while(leftIterator.hasNext())
          leftObject = leftIterator.next()

          rightIterator = rValue.iterator()
          
          Common::Logger.print(Common::VAR_DEBUG, self, "[comma]: rValue iterator: #{rightIterator.to_s()}")
          
          while(rightIterator.hasNext())
            tmpResult = StructResult.new()
          
            rightObject = rightIterator.next()
            
            tmpResult.push(rightObject)
            tmpResult.push(leftObject)
            
            bagResult.push(tmpResult)
          end  
        end
        
        Common::Logger.print(Common::VAR_DEBUG, self, "[comma]: Expression results: #{bagResult.to_s()}")
        Common::Logger.print(Common::VAR_DEBUG, self, "[comma]: #{var_AST.VAR_QRES().to_s()}\n#{var_AST.VAR_ENVS().to_s()}")
        
        return bagResult
      end
  end
end
