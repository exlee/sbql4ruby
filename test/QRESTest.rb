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
        require "lib/QRES/IntegerResult"
        require "lib/QRES/FloatResult"
        
        qresObject_1 = IntegerResult.new(10);
        qresObject_2 = IntegerResult.new(815);
        
        #qresObject_3 = FloatResult.new(10);
        #qresObject_4 = FloatResult.new(333.812);
        
        if(qresObject_1.equals(qresObject_2))
          puts "Equal"
        end
        
        puts("TEST=" + qresObject_1.to_s())
      }
    end
    
  end
       
end
