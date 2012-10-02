module QRES

require "lib/Common/NestedIterator"

require "lib/QRES/QRESComparator"
require "lib/QRES/Utils"


  class AbstractSetQueryResult < AbstractComplexQueryResult
      
      def initialize(var_Object)
        #if(!var_Object.is_a?(Common::Stack))
        #  raise QRESTypeError.new("Incorrect object type [#{var_Object.class}], " + Common::Stack.to_s() + " expected")
        #end
          
        super(var_Object)
      end
 
      # Returns iterator.
      #
      # Params:
      #
      # Returns:BagResultIterator
      #
      # Throws:
      def iterator()
        return Common::Iterator.new(self.VAR_OBJECT().VAR_STACK())
      end

      # Returns nested iterator.
      #
      # Params:
      #
      # Returns:BagResultIterator
      #
      # Throws:
      def nestedIterator()
        return Common::NestedIterator.new(self.VAR_OBJECT().VAR_STACK())
      end
                 
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
        
        leftIterator = self.nestedIterator()
        
        Common::Logger.print(Common::VAR_DEBUG, self, "[comma]: lValue iterator: #{leftIterator.to_s()}")
         
        while(leftIterator.hasNext())
          leftObject = leftIterator.next()

          rightIterator = rValue.nestedIterator()
          
          Common::Logger.print(Common::VAR_DEBUG, self, "[comma]: rValue iterator: #{rightIterator.to_s()}")
          
          while(rightIterator.hasNext())
            tmpResult = StructResult.new()
          
            rightObject = rightIterator.next()
            
            tmpResult.push(leftObject)
            tmpResult.push(rightObject)
            
            bagResult.push(tmpResult)
          end  
        end
        
        Common::Logger.print(Common::VAR_DEBUG, self, "[comma]: #{var_AST.VAR_QRES().to_s()}\n#{var_AST.VAR_ENVS().to_s()}")
        
        return bagResult
      end

      # Evaluates 'min' function 
      #
      # Params:
      #
      # var_RValue:AbstractSimpleQueryResult - QRES simple object
      #
      # Returns:BagResult
      #
      # Throws:
      def min(var_Store)
        Common::Logger.print(Common::VAR_DEBUG, self, "[min]: Executing for: [#{self.to_s()}]")

        iterator = self.nestedIterator()

        Common::Logger.print(Common::VAR_DEBUG, self, "[min]: Iterator for given BagResult: [#{iterator.to_s()}]")

        lastObject = nil
        object = nil

        while(iterator.hasNext())
          object = iterator.next()

          Common::Logger.print(Common::VAR_DEBUG, self, "[min]: An object taken from the iterator: [#{object.to_s()}]")

          object = Utils::dereference(object, var_Store)

          if(!Utils::isNumericType?(object))
            raise SyntaxError.new("Incorrect object type #{object.to_s()}")
          end

          if(lastObject == nil || lastObject > object)  
            Common::Logger.print(Common::VAR_DEBUG, self, "[min]: Last object [#{lastObject.to_s()}], current object [#{object.to_s()}]")

            lastObject = object
          end
        end

        Common::Logger.print(Common::VAR_DEBUG, self, "[min]: Result [#{lastObject.to_s()}]")

        return lastObject
      end
      
      # Overloaded operator 'max'.
      #
      # Params:
      #
      # var_Store:SBAStore - SBA store object
      #
      # Returns:AbstractSimpleQueryResult
      #
      # Throws:    
      def max(var_Store)
        Common::Logger.print(Common::VAR_DEBUG, self, "[max]: Executing for: [#{self.to_s()}]")

        iterator = self.nestedIterator()

        Common::Logger.print(Common::VAR_DEBUG, self, "[max]: Iterator for given BagResult: [#{iterator.to_s()}]")

        lastObject = nil
        object = nil

        while(iterator.hasNext())
          object = iterator.next()

          Common::Logger.print(Common::VAR_DEBUG, self, "[max]: An object taken from the iterator: [#{object.to_s()}]")

          object = Utils::dereference(object, var_Store)

          if(!Utils::isNumericType?(object))
            raise SyntaxError.new("Incorrect object type #{object.to_s()}")
          end

          if(lastObject == nil || lastObject < object)  
            Common::Logger.print(Common::VAR_DEBUG, self, "[max]: Last object [#{lastObject.to_s()}], current object [#{object.to_s()}]")

            lastObject = object
          end
        end

        Common::Logger.print(Common::VAR_DEBUG, self, "[max]: Result [#{lastObject.to_s()}]")

        return lastObject
      end

      # Overloaded operator 'avg'.
      #
      # Params:
      #
      # var_Store:SBAStore - SBA store object
      #
      # Returns:AbstractSimpleQueryResult
      #
      # Throws:    
      def avg(var_Store)
        Common::Logger.print(Common::VAR_DEBUG, self, "[avg]: Executing for: [#{self.to_s()}]")

        iterator = self.nestedIterator()

        Common::Logger.print(Common::VAR_DEBUG, self, "[avg]: Iterator for given BagResult: [#{iterator.to_s()}]")

        avgArray = Array.new()
        object = nil

        while(iterator.hasNext())
          object = iterator.next()

          Common::Logger.print(Common::VAR_DEBUG, self, "[avg]: An object taken from the iterator: [#{object.to_s()}]")

          object = Utils::dereference(object, var_Store)

          if(!Utils::isNumericType?(object))
            raise SyntaxError.new("Incorrect object type #{object.to_s()}")
          end

          Common::Logger.print(Common::VAR_DEBUG, self, "[avg]: Pushing object [#{object.to_s()}], into calculation array")

          avgArray.push(object.VAR_OBJECT())        
        end

        result = FloatResult.new(avgArray.inject{ |sum, el| sum + el }.to_f / avgArray.size)

        Common::Logger.print(Common::VAR_DEBUG, self, "[avg]: Result [#{result.to_s()}]")

        return result
      end
      
      # Evaluates 'set minus' function 
      #
      # Params:
      #
      # var_RValue:AbstractSimpleQueryResult - QRES simple object
      #
      # var_AST:AST - AST object
      #
      # Returns:BagResult
      #
      # Throws:      
      def setMinus(var_RValue, var_AST)
        Common::Logger.print(Common::VAR_DEBUG, self, "Calling operator on the object #{self.to_s()}")  

        bagResult = BagResult.new()

        iterator = self.nestedIterator()

        while(iterator.hasNext())
          object = Utils::getBagResultAsSimpleObject(iterator.next())

          if(!var_RValue.is_contained?(object))
            bagResult.push(object)
          end
        end

        Common::Logger.print(Common::VAR_DEBUG, self, "[eval]: #{bagResult.to_s()}")  

        return bagResult
      end
      
      # Evaluates 'union' function 
      #
      # Params:
      #
      # var_RValue:AbstractSimpleQueryResult - QRES simple object
      #
      # var_AST:AST - AST object
      #
      # Returns:BagResult
      #
      # Throws:      
      def union(var_RValue)
        Common::Logger.print(Common::VAR_DEBUG, self, "Calling operator on the object #{self.to_s()}")  

        bagResult = BagResult.new()

        iterator = self.nestedIterator()

        while(iterator.hasNext())
         bagResult.push(Utils::getBagResultAsSimpleObject(iterator.next()))
        end
        
        iterator = var_RValue.nestedIterator()

        while(iterator.hasNext())
          bagResult.push(Utils::getBagResultAsSimpleObject(iterator.next()))
        end

        Common::Logger.print(Common::VAR_DEBUG, self, "[eval]: #{bagResult.to_s()}")  

        return bagResult
      end
 
      # Sort QRES objects 
      #
      # Params:
      #
      # var_AST:AST - AST object
      #
      # Returns:
      #
      # Throws:      
      def sort(var_AST)
        Common::Logger.print(Common::VAR_DEBUG, self, "Calling operator on the object #{self.to_s()}")  

        @VAR_OBJECT = self.VAR_OBJECT().VAR_STACK().sort{|a1, a2| a1.compare(a2, var_AST)}
      end      
      
      # Compares QRES objects 
      #
      # Params:
      #
      # var_Value:AbstractQueryResult - QRES object
      #
      # var_AST:AST - AST object
      #
      # Returns:Integer
      #
      # Throws:      
      def compare(var_Value, var_AST)
        Common::Logger.print(Common::VAR_DEBUG, self, "Calling operator on the object #{self.to_s()}")  

        return QRESComparator.compare(self, var_Value, var_AST)
      end      
      
      # Return random object 
      #
      # Params:
      #
      # var_Value:
      #
      # var_AST:AST - AST object
      #
      # Returns:AbstractQueryResult
      #
      # Throws:      
      def pickRandom(var_AST)
        Common::Logger.print(Common::VAR_DEBUG, self, "Calling operator on the object #{self.to_s()}")  
        
        return self.VAR_OBJECT.get(rand(self.VAR_OBJECT.size()-1))
      end
    end
end