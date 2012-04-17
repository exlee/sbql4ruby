module AST

require "test/unit"

require "lib/Common/logger"

require "lib/AST/TerminalExpression"
require "lib/AST/StringTerminal"
require "lib/AST/NameExpression"
require "lib/AST/DotExpression"
require "lib/AST/WhereExpression"
require "lib/AST/EqualExpression"
require "lib/AST/GreatherExpression"
require "lib/AST/CommaExpression"
require "lib/AST/BagExpression"
require "lib/AST/StructExpression"
require "lib/AST/MinExpression"
require "lib/AST/MaxExpression"
require "lib/AST/AvgExpression"
require "lib/AST/UnionExpression"
require "lib/AST/SetMinusExpression"
require "lib/AST/IntersectExpression"
require "lib/AST/InExpression"

require "lib/QRES/ReferenceResult"
require "lib/QRES/StructResult"

require "lib/AST/AST"


  class ASTComplexTest < Test::Unit::TestCase
  
    # Tests for AST
    #
    # Params:
    #
    # Returns:
    #
    # Throws:   
    def test_1DotresExpression
      
      assert_nothing_thrown("Creating AST objects") {  
        
        # Set debug log level
        Common::Logger.setLogLevel(Common::VAR_DEBUG)
        
        var_AST = AST.new("sampledata/data.xml")
        
        expression = DotExpression.new(DotExpression.new(NameExpression.new("emp"), NameExpression.new("address")), NameExpression.new("street") )
                        
        expression.execute(var_AST)
        
        result = var_AST.VAR_QRES().pop()
        
        assert_equal("SBA20", result.pop().dereference(var_AST.VAR_STORE()).VAR_ID())
        assert_equal("SBA7", result.pop().dereference(var_AST.VAR_STORE()).VAR_ID())
      }
    end
        
    # Tests for AST
    #
    # Params:
    #
    # Returns:
    #
    # Throws:   
    def test_2WheresExpression
      
      assert_nothing_thrown("Creating AST objects") {  
        
        # Set debug log level
        Common::Logger.setLogLevel(Common::VAR_DEBUG)
        
        var_AST = AST.new("sampledata/data.xml")
        
        #((emp.address) where number==50).(street) 
        expression =  WhereExpression.new(
                        DotExpression.new(  
                          NameExpression.new("emp"), 
                          NameExpression.new("address")),  
                        EqualExpression.new(
                          NameExpression.new("number"), 
                          IntegerTerminal.new(50)))
                        
        expression.execute(var_AST)
        
        assert_equal("SBA32", var_AST.VAR_QRES().pop().dereference(var_AST.VAR_STORE()).VAR_ID())
        
        expression =  WhereExpression.new(
                        DotExpression.new(  
                          NameExpression.new("emp"), 
                          NameExpression.new("address")),  
                        GreatherExpression.new(
                          NameExpression.new("number"), 
                          IntegerTerminal.new(48)))
                          
        expression.execute(var_AST)
        
        result = var_AST.VAR_QRES().pop()
                
        assert_equal("SBA45", result.pop().dereference(var_AST.VAR_STORE()).VAR_ID())
        assert_equal("SBA32", result.pop().dereference(var_AST.VAR_STORE()).VAR_ID())
      }
    end
    
    # Tests for AST
    #
    # Params:
    #
    # Returns:
    #
    # Throws:   
    def test_3CommaExpression
      
      assert_nothing_thrown("Creating AST objects") {  
        
        # Set debug log level
        Common::Logger.setLogLevel(Common::VAR_DEBUG)
        
        var_AST = AST.new("sampledata/data.xml")
        
        expression = CommaExpression.new(CommaExpression.new(IntegerTerminal.new(600), StringTerminal.new("operator test")), FloatTerminal.new(123.321))
        
        expression.execute(var_AST)
        
        result = var_AST.VAR_QRES().pop()
         
        assert_equal("QRES::BagResult", result.class.to_s())
        assert_equal(600, result.pop().VAR_OBJECT())
        assert_equal(123.321, result.pop().VAR_OBJECT())
        assert_equal("operator test", result.pop().VAR_OBJECT())
        assert_equal(123.321, result.pop().VAR_OBJECT())
      }
    end
 
    # Tests for AST
    #
    # Params:
    #
    # Returns:
    #
    # Throws:   
    def test_3BagExpression
      
      assert_nothing_thrown("Creating AST objects") {  
        
        # Set debug log level
        Common::Logger.setLogLevel(Common::VAR_DEBUG)
        
        var_AST = AST.new("sampledata/data.xml")
        
        expression = BagExpression.new(CommaExpression.new(IntegerTerminal.new(600), FloatTerminal.new(123.321)))
        
        expression.execute(var_AST)
        
        result = var_AST.VAR_QRES().pop()
        
        assert_equal("QRES::BagResult", result.class.to_s())
        assert_equal(600, result.pop().VAR_OBJECT())
        assert_equal(123.321, result.pop().VAR_OBJECT())
      }
    end   
 
    # Tests for AST
    #
    # Params:
    #
    # Returns:
    #
    # Throws:   
    def test_3StructExpression
      
      assert_nothing_thrown("Creating AST objects") {  
        
        # Set debug log level
        Common::Logger.setLogLevel(Common::VAR_DEBUG)
        
        var_AST = AST.new("sampledata/data.xml")
        
        expression = StructExpression.new(CommaExpression.new(IntegerTerminal.new(700), FloatTerminal.new(223.321)))
        
        expression.execute(var_AST)
        
        result = var_AST.VAR_QRES().pop()
        
        assert_equal(700, result.pop().VAR_OBJECT())
        assert_equal(223.321, result.pop().VAR_OBJECT())
      }
    end
    
    # Tests for AST
    #
    # Params:
    #
    # Returns:
    #
    # Throws:   
    def test_4MinExpression
      
      assert_nothing_thrown("Creating AST objects") {  
        
        # Set debug log level
        Common::Logger.setLogLevel(Common::VAR_DEBUG)
        
        var_AST = AST.new("sampledata/data.xml")
        
        expression = MinExpression.new(CommaExpression.new(IntegerTerminal.new(888), FloatTerminal.new(11.321)))
        
        expression.execute(var_AST)
        
        assert_equal(11.321, var_AST.VAR_QRES().pop().VAR_OBJECT())
        
        expression = MinExpression.new(CommaExpression.new(CommaExpression.new(IntegerTerminal.new(888), FloatTerminal.new(11.321)), IntegerTerminal.new(12)))
        
        expression.execute(var_AST)
        
        assert_equal(11.321, var_AST.VAR_QRES().pop().VAR_OBJECT())
        
        expression = MinExpression.new(IntegerTerminal.new(12))
        
        expression.execute(var_AST)
        
        assert_equal(12, var_AST.VAR_QRES().pop().VAR_OBJECT())       
      }
    end

    # Tests for AST
    #
    # Params:
    #
    # Returns:
    #
    # Throws:   
    def test_5MaxExpression
      
      assert_nothing_thrown("Creating AST objects") {  
        
        # Set debug log level
        Common::Logger.setLogLevel(Common::VAR_DEBUG)
        
        var_AST = AST.new("sampledata/data.xml")
        
        expression = MaxExpression.new(CommaExpression.new(IntegerTerminal.new(888), FloatTerminal.new(11.321)))
        
        expression.execute(var_AST)
        
        assert_equal(888, var_AST.VAR_QRES().pop().VAR_OBJECT())
        
        expression = MaxExpression.new(CommaExpression.new(CommaExpression.new(IntegerTerminal.new(888), FloatTerminal.new(11.321)), IntegerTerminal.new(12)))
        
        expression.execute(var_AST)
        
        assert_equal(888, var_AST.VAR_QRES().pop().VAR_OBJECT())
        
        expression = MaxExpression.new(IntegerTerminal.new(12))
        
        expression.execute(var_AST)
        
        assert_equal(12, var_AST.VAR_QRES().pop().VAR_OBJECT())
      }
    end
    
    # Tests for AST
    #
    # Params:
    #
    # Returns:
    #
    # Throws:   
    def test_6AvgExpression
      
      assert_nothing_thrown("Creating AST objects") {  
        
        # Set debug log level
        Common::Logger.setLogLevel(Common::VAR_DEBUG)
        
        var_AST = AST.new("sampledata/data.xml")
        
        expression = AvgExpression.new(CommaExpression.new(IntegerTerminal.new(888), FloatTerminal.new(11.321)))
        
        expression.execute(var_AST)
        
        assert_equal(449.6605, var_AST.VAR_QRES().pop().VAR_OBJECT())
        
        expression = AvgExpression.new(
                      BagExpression.new(
                        CommaExpression.new(
                        CommaExpression.new(
                          IntegerTerminal.new(888), 
                          FloatTerminal.new(11.321)
                        ), 
                        IntegerTerminal.new(12))
                      )
                    )
        
        expression.execute(var_AST)
        
        assert_equal(230.83025, var_AST.VAR_QRES().pop().VAR_OBJECT())
        
        expression = AvgExpression.new(IntegerTerminal.new(12))
        
        expression.execute(var_AST)
        
        assert_equal(12, var_AST.VAR_QRES().pop().VAR_OBJECT())
      }
    end
    
    # Tests for AST
    #
    # Params:
    #
    # Returns:
    #
    # Throws:   
    def test_6UnionExpression
      
      assert_nothing_thrown("Creating AST objects") {  
        
        # Set debug log level
        Common::Logger.setLogLevel(Common::VAR_DEBUG)
        
        var_AST = AST.new("sampledata/data.xml")
        
        expression =  UnionExpression.new(
                        BagExpression.new(CommaExpression.new(IntegerTerminal.new(888), FloatTerminal.new(11.321))),
                        BagExpression.new(CommaExpression.new(StringTerminal.new("Test"), IntegerTerminal.new(600))))
        
        expression.execute(var_AST)

        result = var_AST.VAR_QRES().pop()
        
        assert_equal("QRES::BagResult", result.class.to_s())
        assert_equal("Test", result.pop().VAR_OBJECT())
        assert_equal(600, result.pop().VAR_OBJECT())
        assert_equal(888, result.pop().VAR_OBJECT())
        assert_equal(11.321, result.pop().VAR_OBJECT())
        
        expression =  UnionExpression.new(
                        StructExpression.new(CommaExpression.new(IntegerTerminal.new(888), FloatTerminal.new(11.321))),
                        StructExpression.new(CommaExpression.new(StringTerminal.new("Test"), IntegerTerminal.new(600))))
        
        expression.execute(var_AST)
        
        result = var_AST.VAR_QRES().pop()
        
        assert_equal("QRES::BagResult", result.class.to_s())
        assert_equal("Test", result.pop().VAR_OBJECT())
        assert_equal(600, result.pop().VAR_OBJECT())
        assert_equal(888, result.pop().VAR_OBJECT())
        assert_equal(11.321, result.pop().VAR_OBJECT())
      }
    end
    
    # Tests for AST
    #
    # Params:
    #
    # Returns:
    #
    # Throws:   
    def test_7SetMinusExpression
      
      assert_nothing_thrown("Creating AST objects") {  
        
        # Set debug log level
        Common::Logger.setLogLevel(Common::VAR_DEBUG)
        
        var_AST = AST.new("sampledata/data.xml")
        
        expression =  SetMinusExpression.new(
                        BagExpression.new(CommaExpression.new(IntegerTerminal.new(888), FloatTerminal.new(11.321))),
                        BagExpression.new(CommaExpression.new(StringTerminal.new("Test"), IntegerTerminal.new(888))))
        
        expression.execute(var_AST)

        result = var_AST.VAR_QRES().pop()
        
        assert_equal("QRES::BagResult", result.class.to_s())
        assert_equal(11.321, result.pop().VAR_OBJECT())
        
        expression =  SetMinusExpression.new(
                        StructExpression.new(CommaExpression.new(IntegerTerminal.new(888), FloatTerminal.new(11.321))),
                        StructExpression.new(CommaExpression.new(StringTerminal.new("Test"), IntegerTerminal.new(600))))
        
        expression.execute(var_AST)
        
        result = var_AST.VAR_QRES().pop()
        
        assert_equal("QRES::BagResult", result.class.to_s())
        assert_equal(888, result.pop().VAR_OBJECT())
        assert_equal(11.321, result.pop().VAR_OBJECT())
      }
    end
    
    # Tests for AST
    #
    # Params:
    #
    # Returns:
    #
    # Throws:   
    def test_8IntersectExpression
      
      assert_nothing_thrown("Creating AST objects") {  
        
        # Set debug log level
        Common::Logger.setLogLevel(Common::VAR_DEBUG)
        
        var_AST = AST.new("sampledata/data.xml")
        
        expression =  IntersectExpression.new(
                        BagExpression.new(CommaExpression.new(IntegerTerminal.new(888), FloatTerminal.new(11.321))),
                        BagExpression.new(CommaExpression.new(StringTerminal.new("Test"), IntegerTerminal.new(888))))
        
        expression.execute(var_AST)

        result = var_AST.VAR_QRES().pop()
        
        assert_equal("QRES::BagResult", result.class.to_s())
        assert_equal(888, result.pop().VAR_OBJECT())
        
        expression =  IntersectExpression.new(
                        StructExpression.new(CommaExpression.new(IntegerTerminal.new(888), FloatTerminal.new(11.321))),
                        StructExpression.new(CommaExpression.new(StringTerminal.new("Test"), IntegerTerminal.new(600))))
        
        expression.execute(var_AST)
        
        result = var_AST.VAR_QRES().pop()
        
        assert_equal("QRES::BagResult", result.class.to_s())
        assert_equal(0, result.VAR_OBJECT().size())
      }
    end

    # Tests for AST
    #
    # Params:
    #
    # Returns:
    #
    # Throws:   
    def test_9InExpression
      
      assert_nothing_thrown("Creating AST objects") {  
        
        # Set debug log level
        Common::Logger.setLogLevel(Common::VAR_DEBUG)
        
        var_AST = AST.new("sampledata/data.xml")
        
        expression =  InExpression.new(
                        BagExpression.new(CommaExpression.new(IntegerTerminal.new(888), FloatTerminal.new(11.321))),
                        BagExpression.new(CommaExpression.new(StringTerminal.new("Test"), IntegerTerminal.new(888))))
        
        expression.execute(var_AST)

        result = var_AST.VAR_QRES().pop()
        
        assert_equal("QRES::BagResult", result.class.to_s())
        assert_equal(0, result.VAR_OBJECT().size())
        
        expression =  IntersectExpression.new(
                        StructExpression.new(CommaExpression.new(IntegerTerminal.new(888), FloatTerminal.new(11.321))),
                        StructExpression.new(CommaExpression.new(FloatTerminal.new(11.321), IntegerTerminal.new(888))))
        
        expression.execute(var_AST)
        
        result = var_AST.VAR_QRES().pop()
        
        assert_equal("QRES::BagResult", result.class.to_s())
        assert_equal(888, result.pop().VAR_OBJECT())
        assert_equal(11.321, result.pop().VAR_OBJECT())      
        }
    end
  end
end
