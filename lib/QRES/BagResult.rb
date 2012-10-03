module QRES

require "lib/Common/Stack"

require "lib/QRES/Utils"
require "lib/QRES/InternalException"
require "lib/QRES/AbstractSetQueryResult"

  # Class: BagResult
  # Extends: AbstractSetQueryResult
  # 
  # Implements Query result in Bag form
  class BagResult < AbstractSetQueryResult
    
    # Method: initialize (constructor)
    # 
    # Initializes new Bag result
    # 
    # Params: None
    def initialize()
      super(Common::Stack.new())
    end

    # Method: push
    #
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
      #if(var_Object.is_a?(BagResult) || var_Object.is_a?(StructResult))
      if(var_Object.is_a?(BagResult))
        for i in 0..var_Object.VAR_OBJECT.size()-1
          self.push(var_Object.VAR_OBJECT.get(i))
        end
      else
        self.VAR_OBJECT.push(var_Object)
      end
    end

    # Method: pop
    #
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

    # Method: equals
    #
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
     
      iterator = self.nestedIterator()
      
      while(iterator.hasNext())
        object = Utils::getBagResultAsSimpleObject(iterator.next())

        if(object == var_Object)
          return true
        end
      end
             
      return false
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
    
    # Method: isSimpleObject?
    #
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
    
    # Method: getAsSimpleResult
    #
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
