module QRES

require "lib/QRES/AbstractSetQueryResult"
require "lib/QRES/StructResultIterator"


  # Class: StructResult
  # Extends: AbstractComplexQueryResult
  #
  # Implements query result for Struct object
  class StructResult < AbstractSetQueryResult
    
    # Method: initialize (constructor)
    # 
    # Initializes new StructResult object
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
      
      # Pushing BagResult or StructResult to another StructResult
      #if(var_Object.is_a?(BagResult) || var_Object.is_a?(StructResult))
      if(var_Object.is_a?(StructResult) || var_Object.is_a?(BagResult))
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

    # Method: isSimpleObject?
    #
    # Checks whether current complex object object may be treated
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
    # Checks whether current complex object may be treated
    # as simple object (is has to provide exactly one simple object).
    #
    # Params:
    #
    # Returns:TrueClass/FalseClass
    #
    # Throws:AbstractSimpleQueryResult
    def getAsSimpleResult()
      Common::Logger.print(Common::VAR_DEBUG, self, "[getAsSimpleResult]: Executing in context of current object: [#{self.to_s()}]")

      if(!self.isSimpleObject?())
        raise InternalException.new("Currect BagResult can't be treated as simple object [#{self.to_s()}]")
      end

      Common::Logger.print(Common::VAR_DEBUG, self, "[getAsSimpleResult]: Returning: [#{self.VAR_OBJECT.get(self.VAR_OBJECT.size()-1)}]")

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

        # Executing right hand side
        var_RValue.execute(var_AST)

        var_RValue = var_AST.VAR_QRES().pop()
      end      

      Common::Logger.print(Common::VAR_DEBUG, self, "[comma]: rValue is executed, stacks dump:")
      Common::Logger.print(Common::VAR_DEBUG, self, "[comma]: #{var_AST.VAR_QRES().to_s()}\n#{var_AST.VAR_ENVS().to_s()}")
      
      puts "AAA/Struct/: lValue=#{self.to_s()}, rValue=#{var_RValue.to_s()}"
      
      # s(1,2), s(3,4) = b(s(1,2,3,4)) = proxy[b(s(1,2,3,4))]
      # s(1,2), 3 = b(s(1,2,3)) = proxy[b(s(1,2,3))]
      
      # Struct Simple - tutaj jest problem
      if(Utils::isStructResult?(var_RValue) || Utils::isBagQualifiedForProxy(var_RValue) || Utils::isSimpleObject?(var_RValue))
        #tmpResult = StructResult.new()
        
        puts "AAA/Struct/Struct or simple/ self=#{self.to_s()}, rval=#{var_RValue.to_s()}"
        
        if(Utils::isSimpleObject?(var_RValue))
          self.push(var_RValue)
          bagResult.push(self)
        else
          bagResult.push(self)
          bagResult.push(var_RValue)
        end
        
        #bagResult.push(tmpResult)
        
        puts "AAA/Struct/Struct or simple/ result=#{bagResult.to_s()}"        
        
        return bagResult
      end
       
      # s(3,4), b(5,6) = b(s(3,4,5), s(3,4,6))
      rightIterator = self.iterator()
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[comma]: rValue iterator: #{rightIterator.to_s()}")
       
      while(rightIterator.hasNext())
        
        rightObject = rightIterator.next()

        puts "AAA/Struct/bag/: #{rightObject.to_s()}"
        
        Common::Logger.print(Common::VAR_DEBUG, self, "[comma]: rValue iterator: #{rightIterator.to_s()}")
        
        aaa = leftObject.comma(rightObject)
        bagResult.push(aaa)

        puts "AAA/bag/matching/: #{aaa.to_s()}"
      end
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[comma]: #{var_AST.VAR_QRES().to_s()}\n#{var_AST.VAR_ENVS().to_s()}")
      
      return bagResult
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
