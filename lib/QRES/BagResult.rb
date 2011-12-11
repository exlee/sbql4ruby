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
      
      # Pushing BagResult to another BagResult
      if(var_Object.is_a?(BagResult))
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
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[dereference]: Executing in context of current object: [#{self.to_s()}], stacks dump:")
      Common::Logger.print(Common::VAR_DEBUG, self, "[dereference]: #{@VAR_QRES.to_s()}\n#{@VAR_ENVS.to_s()}")    
      
      # Dereference works well when the bag's stack provides one object
      if(self.VAR_OBJECT().size() != 1)
        raise InternalException.new("Incorrect stack size [#{self.VAR_OBJECT().size()}], extected [1]")
      end
      
      var_SBAObject = var_Store.find(self.VAR_OBJECT().get(self.VAR_OBJECT().size()-1))
      
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
     
     var_Object = self.VAR_OBJECT.get[VAR_OBJECT.size()-1]
     
     if(!var_Object.is_a?(AbstractSimpleQueryResult))
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
     
      Common::Logger.print(Common::VAR_DEBUG, self, "[getAsSimpleResult]: Returning: [#{self.VAR_OBJECT.get[VAR_OBJECT.size()-1]}]")
      
      return self.VAR_OBJECT.get[VAR_OBJECT.size()-1]
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