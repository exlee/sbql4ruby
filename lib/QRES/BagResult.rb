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
      #if(var_Object.is_a?(BagResult) || (var_Object.is_a?(StructResult) && self.VAR_OBJECT.size()==0))
      if(var_Object.is_a?(BagResult))  
        if(var_Object.VAR_OBJECT.is_a?Array)
          for i in 0..var_Object.VAR_OBJECT.size()-1
            self.push(var_Object.VAR_OBJECT[i])
          end
        else
          for i in 0..var_Object.VAR_OBJECT.size()-1
            self.push(var_Object.VAR_OBJECT.get(i))
          end
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
      # Bag proxy
      #bagAfterProxy = Utils::bagResultProxy(self)
      
      # Proxy did not change anything
      if(!Utils::isBagQualifiedForProxy(self))
        #if(self.equals(bagAfterProxy))
        return self.VAR_OBJECT.pop()
      end
      
      # Proxy has modified given bag result
      # Thers is only one object provided by bag result,
      # it's struct result.
      # In this case pop on the bag needs to be treated
      # like pop on the encapsulated struct.
      
      return self.VAR_OBJECT.get(0).pop()
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
      if(!var_Object.is_a?(AbstractSimpleQueryResult) and !var_Object.is_a?(ReferenceResult))
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
      
      if(Utils::isBagQualifiedForProxy(self))
        if(self.VAR_OBJECT.get(0).VAR_OBJECT.size() != 1)
          return false
        end
        
        var_Object = self.VAR_OBJECT.get(0).VAR_OBJECT.get(0)
      else
        var_Object = self.VAR_OBJECT.get(self.VAR_OBJECT.size()-1)
      end
      
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
      
      #if(!self.isSimpleObject?())
      #  raise InternalException.new("Currect BagResult can't be treated as simple object [#{self.to_s()}]")
      #end
     
      Common::Logger.print(Common::VAR_DEBUG, self, "[getAsSimpleResult]: Returning: [#{self.VAR_OBJECT.get(self.VAR_OBJECT.size()-1)}]")
      
      if(Utils::isBagQualifiedForProxy(self))
        return self.VAR_OBJECT.get(0).VAR_OBJECT.get(0)  
      end
      
      return self.VAR_OBJECT.get(self.VAR_OBJECT.size()-1)
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
      
      if(var_RValue.is_a?(AST::Expression))
        var_RValue.execute(var_AST)
        rightResult = var_AST.VAR_QRES().pop()
      elsif(var_RValue.is_a?AbstractQueryResult)
        rightResult = var_RValue
      else
        raise IncorrectArgumentException.new("Unsupported data type: " + var_RValue.class.to_s)
      end
      
      self.iterator.each do |item|
        struct = StructResult.new
        struct.push(item)
        struct.push(rightResult)
        
        bagResult.push(struct)
        
        
      end

      return bagResult
    end
    
    def size
      return self.VAR_OBJECT.size()
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
    
    # Method: to_s
    #
    # Return self. Method made for SBAComplexObject, which sometimes
    # can return bag, where SBAObject is expected.
    #
    # Params:
    #
    # Returns: Bag
    def to_qres()
      return self
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
    
    # Alias for push method.
    #
    # Params:
    #
    # var_Object:AbstractQueryResult - QRES object
    #
    # Returns:
    #
    # Throws:
    alias == equals  
  end
end
