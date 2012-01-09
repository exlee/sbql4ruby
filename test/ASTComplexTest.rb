module AST

require "test/unit"

require "lib/Common/logger"

require "lib/AST/TerminalExpression"
require "lib/AST/NameExpression"
require "lib/AST/DotExpression"
require "lib/AST/WhereExpression"
require "lib/AST/EqualExpression"
require "lib/AST/GreatherExpression"

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
    def test_DotresExpression
      
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
    def test_WheresExpression
      
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
  end
end
