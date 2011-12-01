module AST

require "test/unit"

require "lib/Common/logger"
require "lib/AST/TerminalExpression"
require "lib/AST/StringTerminal"
require "lib/AST/IntegerTerminal"
require "lib/AST/BinaryExpression"

require "lib/AST/AnyExpression"
require "lib/AST/AsExpression"


  class ASTTest < Test::Unit::TestCase
  
    # Tests for AST
    #
    # Params:
    #
    # Returns:
    #
    # Throws:   
    def test_AST
      
      assert_nothing_thrown("Creating AST objects") {  
        
        # Set debug log level
        Common::Logger.setLogLevel(Common::VAR_DEBUG)
        
        stringTerminal = StringTerminal.new("Test") 
        integerTerminal = IntegerTerminal.new(10)
        
        binaryExpression = BinaryExpression.new(stringTerminal, integerTerminal)
        anyExpression = AnyExpression.new(stringTerminal, integerTerminal)
        asExpression = AsExpression.new(stringTerminal, integerTerminal)
  
        puts binaryExpression.to_s()
        puts anyExpression.to_s()
        puts asExpression.to_s()
        }
    end
    
  end
       
end
