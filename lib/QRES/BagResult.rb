module QRES

require "lib/Common/Stack"

require "lib/QRES/AbstractComplexQueryResult"
require "lib/QRES/BagResultIterator"

require "lib/QRES/InternalException"


  class BagResult < AbstractComplexQueryResult
    
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
      
      # Pushing BagResult or StructResult to another BagResult
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
    # var_Object:BagResult
    #
    # Returns:TrueClass/FalseClass
    #
    # Throws:
    def equals(var_Object)
      if(var_Object.is_a?(BagResult))
        return super(var_Object)
      end
      
      raise QRESTypeError.new("Incorrect object type [#{var_Object.class}], " + BagResult.to_s() + " expected")
    end

    # Returns iterator.
    #
    # Params:
    #
    # Returns:BagResultIterator
    #
    # Throws:
    def iterator()
      return BagResultIterator.new(self)
    end
    
    # Dereferences current QRES object searching in SBA store.
    #
    # Params:
    #
    # var_Store:SBAStore - SBA store object
    #
    # Returns:SBAObject
    #
    # Throws:IncorrectArgumentException
    def dereference(var_Store)
      if(!var_Store.is_a?(SBAStore::SBAStore))
        raise IncorrectArgumentException.new("Incorrect argument type [#{var_Store.to_s()}] , expected [SBAStore]")
      end      
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[dereference]: Executing in context of current object: [#{self.to_s()}]")  
      
      var_SBAObject = var_Store.find(self.getAsSimpleResult().VAR_OBJECT())
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[dereference]: Found [#{var_SBAObject.to_s()}]")
      
      return var_SBAObject
    end
    
    # Checks whether current BagResult object may be treated
    # as simple object (is has to provide exactly one simple object).
    #
    # Params:
    #
    # Returns:TrueClass/FalseClass
    #
    # Throws:
    def isSimpleObject?()
     if(self.VAR_OBJECT.size() != 1)
       return false
     end
     
     var_Object = self.VAR_OBJECT.get(self.VAR_OBJECT.size()-1)
     
     if(!var_Object.is_a?(AbstractSimpleQueryResult) && !var_Object.is_a?(ReferenceResult))
       return false
     end
      
     return true
    end
    
    # Checks whether current BagResult object may be treated
    # as simple object (is has to provide exactly one simple object).
    #
    # Params:
    #
    # Returns:TrueClass/FalseClass
    #
    # Throws:InternalException
    def getAsSimpleResult()
      Common::Logger.print(Common::VAR_DEBUG, self, "[getAsSimpleResult]: Executing in context of current object: [#{self.to_s()}]")
      
      if(!self.isSimpleObject?())
        raise InternalException.new("Currect BagResult can't be treated as simple object [#{self.to_s()}]")
      end
     
      Common::Logger.print(Common::VAR_DEBUG, self, "[getAsSimpleResult]: Returning: [#{self.VAR_OBJECT.get(self.VAR_OBJECT.size()-1)}]")
      
      return self.VAR_OBJECT.get(self.VAR_OBJECT.size()-1)
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
      
      while(bagIterator.hasNext())
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