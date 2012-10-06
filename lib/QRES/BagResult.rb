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
      
      puts "aaa: qualified as bag->struct proxy"
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
      
      # Evaluating the right side of the expression
      if(!var_RValue.is_a?(AbstractQueryResult))

        # Evaluating the right side of the expression
        var_RValue.execute(var_AST)

        var_RValue = var_AST.VAR_QRES().pop()
      end      

      Common::Logger.print(Common::VAR_DEBUG, self, "[comma]: rValue is executed, stacks dump:")
      Common::Logger.print(Common::VAR_DEBUG, self, "[comma]: #{var_AST.VAR_QRES().to_s()}\n#{var_AST.VAR_ENVS().to_s()}")
      
      puts "AAA\BAG\: lValue=#{self.to_s()}, rlValue=#{var_RValue.to_s()}"
      
      #var_TmpRValue = Uitls::getBagResultAsSimpleObject(var_RValue)
            
      # b(1,2), 3 = b(1,2,3)
      # b(s(1,2)), 3 = b(s(1,2,3)) = proxy[b(s(1,2,3))]
      #if(Utils::isSimpleBag?(self) || (Utils::isBagQualifiedForProxy(self) && Utils::isSimpleObject?(var_RValue)))
      if( (Utils::isSimpleBag?(self)            && Utils::isSimpleObject?(var_RValue)) || 
          (Utils::isBagQualifiedForProxy(self)  && Utils::isSimpleObject?(var_RValue)))
        
        tmpResult = StructResult.new()   
        puts "\n\nDUPA PRZED: #{self.to_s()}, #{var_RValue.to_s()}"
        tmpResult.push(self)
        tmpResult.push(var_RValue)
        
        bagResult.push(tmpResult)   
        
        Common::Logger.print(Common::VAR_DEBUG, self, "[comma]: Result=#{bagResult.to_s()}")
        puts "\n\nAAA\BAG\GDUPA: #{bagResult.to_s()}"
        return bagResult
      end
              
      # proxy[b(s(1,2))], b(3,4) = b(s(1,2), s(1,4), s(2,3), s(2,4)) 
      if(Utils::isBagQualifiedForProxy(self) && Utils::isSimpleBag?(var_RValue))
        puts "ERROR"
        var_LValue = Utils::bagResultProxy(self)
      else
        var_LValue = self
      end
      
      #  b(1,2), proxy[b(s(3,4))]= b(s(1,2), s(1,4), s(2,3), s(2,4)) 
      if(Utils::isSimpleBag?(var_RValue) && Utils::isBagQualifiedForProxy(self))
        var_RValue = Utils::bagResultProxy(var_RValue)
      end
      
      puts "AAA CIPA #{var_LValue.to_s()}, #{var_RValue.to_s()}"
      
      # b(s(1,2)), s(3,4) = b(s(1,2),s(3,4))
      # b(s(1,2), s(3,4)), 5 = b(s(1,2,5), s(3,4,5))
      # b(s(1,2), s(3,4)), s(5, 6) = b(s(1,2,5,6), s(3,4,5,6))
      # b(s(1,2), s(3,4)), b(5,6) = b(s(1,2,5), s(1,2,6), s(3,4,5), s(3,4,6)))           
      leftIterator = var_LValue.iterator()
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[comma]: lValue iterator: #{leftIterator.to_s()}")
       
      while(leftIterator.hasNext())
        leftObject = leftIterator.next()
        
        Common::Logger.print(Common::VAR_DEBUG, self, "[comma]: rValue iterator: #{leftIterator.to_s()}")

        puts "dupa/left-bag-iterator/: #{leftIterator.to_s()}, object already taken from iterator #{leftObject.to_s()}"
        
        # Proxy
        if(Utils::isSimpleBag?(var_RValue))
          rightIterator = var_RValue.nestedIterator() 
        elsif(Utils::isStructResult?(var_RValue))
          
          # proxy[b(s(3,4))], s(1,2) -> proxy[b(s(3,4))], s(1,2) <- interator
          tmpBag = BagResult.new()
          tmpBag.push(var_RValue)

          var_RValue = tmpBag
          
          rightIterator = var_RValue.iterator()
          
          puts "AAA right val will be change into bag(s): #{var_RValue.to_s()}"
        else
          rightIterator = var_RValue.iterator()
        end
          
        while(rightIterator.hasNext())
          
          rightObject = rightIterator.next()
          
          puts "AAA DUPA #{leftObject.to_s()} comma #{rightObject.to_s()}"
          
          aaa = leftObject.comma(rightObject, var_AST)
          bagResult.push(aaa)

          puts "AAA/bag/matching/: #{aaa.to_s()}"          
        end
      end
      
      puts "AAA Final #{bagResult.to_s()}"
      Common::Logger.print(Common::VAR_DEBUG, self, "[comma]: #{var_AST.VAR_QRES().to_s()}\n#{var_AST.VAR_ENVS().to_s()}")
      
      return bagResult
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
