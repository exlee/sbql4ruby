module QRES

require "test/unit"

require 'lib/Common/logger'


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
        require "lib/QRES/AbstractQueryResult"
        require "lib/QRES/AbstractComplexQueryResult"
        require "lib/QRES/IntegerResult"
        require "lib/QRES/FloatResult"
        require "lib/QRES/StringResult"
        require "lib/QRES/BagResult"
        require "lib/Common/Stack"
        
        qresObject_1 = IntegerResult.new(10);
        qresObject_2 = IntegerResult.new(815);
        
        #qresObject_3 = FloatResult.new(10);
        #qresObject_4 = FloatResult.new(333.812);
        
        if(qresObject_1.equals(qresObject_2))
          puts "Equal"
        end
        
        puts("TEST=" + qresObject_1.to_s())
        
        # test:
        #puts "STACK: tail/bottom -> x, y, z <- head/top"
        #lstack = Common::LIFOStack.new
        #lstack.push 'x'
        #lstack.push 'y'
        #lstack.push 'z'
        # or equivalently, stack = Stack.new('x', 'y', 'z')
        #until lstack.empty?
        #  puts "popping stack, item: #{lstack.pop}"
        #end
        
        #lstack.pop()
        
        #until lstack.empty?
        #  puts "popping stack, item: #{lstack.pop}"
        #end
        
        # prints items in reverse order: 'z', 'y', 'x'
        
        stack = Common::Stack.new()
        stack2 = Common::Stack.new()
        
        stack.push("Dupa")
        stack.push("2Dupa")
        
        stack2.push(stack.get(0))
        stack2.push(false)
        
        if(!stack.equals(stack2))
          puts "IIICHCHCHAAAA"
        end
        
        puts "TTEST=" + stack.pop()
        puts "TTEST=" + stack.pop()
        
        bagResult = BagResult.new()
        bagResult.push(IntegerResult.new(10))
        bagResult.push(FloatResult.new(10.123))
        bagResult.push(StringResult.new("String test"))     
           
        if(bagResult.equals(bagResult))
          puts "bag results are equal!"
        end
        
        bagResult2 = BagResult.new()
        bagResult2.push(FloatResult.new(10.123))
        bagResult2.push(IntegerResult.new(10))
        bagResult2.push(StringResult.new("String test"))     
        
        bagResult2.push(bagResult)
        
        puts "bagResult2=" + bagResult2.to_s()
        
        if(!bagResult.equals(bagResult2))
          puts "bag results are equal!"
        end
      }
    end
    
  end
       
end
