module QRES

require "test/unit"

require 'lib/Common/logger'
require "lib/QRES/AbstractQueryResult"
require "lib/QRES/AbstractComplexQueryResult"
require "lib/QRES/IntegerResult"
require "lib/QRES/FloatResult"
require "lib/QRES/StringResult"
require "lib/QRES/BooleanResult"
require "lib/QRES/BagResult"
require "lib/QRES/StructResult"
require "lib/QRES/BinderResult"
require "lib/QRES/QRES"
require "lib/Common/Stack"
  

  class QRESTest < Test::Unit::TestCase
  
    # Creates few QRES objects.
    #
    # Params:
    #
    # Returns:
    #
    # Throws:   
    def test_QRES
      
      assert_nothing_thrown("Creating QRES objects") {
        
        qresObject_1 = IntegerResult.new(10);
        qresObject_2 = IntegerResult.new(815);
        
        assert_equal(false, qresObject_1.equals(qresObject_2))
        
        stack = Common::Stack.new()
        stack2 = Common::Stack.new()
        
        stack.push("String object 1")
        stack.push("String object 2")
        
        stack2.push(stack.get(0))
        stack2.push(false)
        
        assert_equal(false, stack.equals(stack2))
        
        stack.pop()
        stack.pop()
        
        bagResult = BagResult.new()
        bagResult.push(IntegerResult.new(10))
        bagResult.push(FloatResult.new(10.123))
        bagResult.push(StringResult.new("String test"))     
           
        assert_equal(true, bagResult.equals(bagResult))
        
        bagResult2 = BagResult.new()
        bagResult2.push(FloatResult.new(10.123))
        bagResult2.push(IntegerResult.new(10))
        bagResult2.push(StringResult.new("String test"))     
        
        bagResult2.push(bagResult)
       
        assert_equal(false, bagResult.equals(bagResult2))
        
        qres = QRES.new()
        qres.push(qresObject_1)
        qres.push(bagResult)
      }
    end
    
    # (bag("JPS" + "rules", 2.2, true)) groupas x;
    #
    # Params:
    #
    # Returns:
    #
    # Throws:   
    def test_QRES2
      
      assert_nothing_thrown("Creating QRES objects") {
        
        qres = QRES.new()
        
        qres.push(StringResult.new("JPS"))
        qres.push(StringResult.new("rulez"))
        
        stringResult1 = qres.pop()
        stringResult2 = qres.pop()
        
        qres.push(StringResult.new(stringResult1.VAR_OBJECT + stringResult2.VAR_OBJECT))
        
        qres.push(FloatResult.new(2.2))
        
        floatResult = qres.pop()
        stringResult1 = qres.pop()
        
        structResult = StructResult.new()
        
        structResult.push(stringResult1)
        structResult.push(floatResult)
    
        qres.push(structResult)
        qres.push(BooleanResult.new(true))
        
        booleanResult = qres.pop()
        structResult = qres.pop()
        
        structResult.push(booleanResult)
        
        qres.push(structResult)
        
        bagResult = BagResult.new()
        
        structResult = qres.pop()
        
        bagResult.push(structResult)
        
        qres.push(bagResult)
        
        qres.push(BinderResult.new("x", qres.pop()))
        
        puts qres.to_s()
      }
    end
    
  end
       
end
