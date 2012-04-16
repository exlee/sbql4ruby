module QRES

require "lib/QRES/StructResultIterator"


  class StructResult < AbstractComplexQueryResult
    
    def initialize()
      super(Common::Stack.new())
    end

    # Push QRES object into BagResult 
    #
    # Params:
    #
    # var_Object:AbstractQueryResult - QRES object
    #
    # Returns:
    #
    # Throws:    
    def push(var_Object)
      
      # Pushing BagResult or StructResult to another StructResult
      if(var_Object.is_a?(BagResult) || var_Object.is_a?(StructResult))
        for i in 0..var_Object.VAR_OBJECT.size()-1
          self.VAR_OBJECT.push(var_Object.VAR_OBJECT.get(i))
        end
      else
        self.VAR_OBJECT.push(var_Object)
      end
    end

    # Gets QRES object from BagResult 
    #
    # Params:
    #
    # Returns:AbstractQueryResult
    #
    # Throws:    
    def pop()
      return self.VAR_OBJECT.pop()
    end

    # Compares QRES value objects 
    #
    # Params:
    #
    # var_Object:StructResult
    #
    # Returns:TrueClass/FalseClass
    #
    # Throws:
    def equals(var_Object)
      if(var_Object.is_a?(StructResult))
        return super(var_Object)
      end

      raise QRESTypeError.new("Incorrect object type [#{var_Object.class}], " + StructResult.to_s() + " expected")
    end
    
    # Finds QRES objects in BagResult
    # and returns 'true' if found
    #
    # Params:
    #
    # var_Object:AbstractSimpleQueryResult
    #
    # Returns:TrueClass/FalseClass
    #
    # Throws:
    def is_contained?(var_Object)
      if(!var_Object.is_a?(AbstractSimpleQueryResult))
        throw QRESTypeError.new("Incorrect object type [#{var_Object.class}], " + AbstractSimpleQueryResult.to_s() + " expected")
      end
     
      @VAR_OBJECT.VAR_STACK().each() do|object|
        if(object == var_Object)
          return true
        end
      end
      
      return false
    end

    # Returns iterator.
    #
    # Params:
    #
    # Returns:StructResultIterator
    #
    # Throws:
    def iterator()
      return StructResultIterator.new(self)
    end

    # Overloaded operator 'min'.
    #
    # Params:
    #
    # var_Store:SBAStore - SBA store object
    #
    # Returns:AbstractSimpleQueryResult
    #
    # Throws:    
    def min(var_Store)
      Common::Logger.print(Common::VAR_DEBUG, self, "[min]: Executing for: [#{self.to_s()}]")
       
      bagIterator = self.iterator()
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[min]: Iterator for given BagResult: [#{iterator.to_s()}]")
      
      lastObject = nil
      object = nil
      
      while(structIterator.hasNext())
        object = bagIterator.next()
                      
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
       
      bagIterator = self.iterator()
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[max]: Iterator for given BagResult: [#{iterator.to_s()}]")
      
      lastObject = nil
      object = nil
      
      while(bagIterator.hasNext())
        object = bagIterator.next()
                      
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
       
      bagIterator = self.iterator()
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[avg]: Iterator for given BagResult: [#{iterator.to_s()}]")
      
      avgArray = Array.new()
      object = nil
      
      while(bagIterator.hasNext())
        object = bagIterator.next()
                      
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
             
    # Returns a string representation of QRES value object.
    #
    # Params:
    #
    # Returns:String
    #
    # Throws:
    def to_s()
      return self.class.to_s() + super()
    end
        
    # Alias for push method.
    #
    # Params:
    #
    # var_Object:AbstractQueryResult - QRES object
    #
    # Returns:
    #
    # Throws:
    alias add push
          
  end

end