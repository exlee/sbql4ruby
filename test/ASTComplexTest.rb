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

require "lib/QRES/ReferenceResult"

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
      }
    end
       
  end
end
