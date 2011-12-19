module AST

require "test/unit"

require "lib/Common/logger"
require "lib/AST/TerminalExpression"
require "lib/AST/StringTerminal"
require "lib/AST/IntegerTerminal"
require "lib/AST/BooleanTerminal"
require "lib/AST/BinaryExpression"

require "lib/AST/PlusExpression"
require "lib/AST/MinusExpression"
require "lib/AST/MultiplyExpression"
require "lib/AST/DivideExpression"
require "lib/AST/EqualExpression"
require "lib/AST/GreatherExpression"
require "lib/AST/GreatherEqualExpression"
require "lib/AST/LessExpression"
require "lib/AST/LessEqualExpression"

require "lib/AST/AnyExpression"
require "lib/AST/AsExpression"

require "lib/AST/AST"

require "lib/QRES/BooleanResult"


  class ASTTest < Test::Unit::TestCase
  

    # Tests for 'equal' expression
    #
    # Params:
    #
    # Returns:
    #
    # Throws:   
    def test_EqualExpression
      
      # Set debug log level
      Common::Logger.setLogLevel(Common::VAR_DEBUG)   
      
      assert_nothing_thrown("Creating AST objects") { 
        
      var_AST = AST.new("sampledata/data.xml")
 
      # false == true
      equalExpression = EqualExpression.new(BooleanTerminal.new(false), BooleanTerminal.new(true))
      equalExpression.execute(var_AST)
      
      assert_equal(false, var_AST.VAR_QRES().pop().VAR_OBJECT())

      # true == true
      equalExpression = EqualExpression.new(BooleanTerminal.new(true), BooleanTerminal.new(true))
      equalExpression.execute(var_AST)
      
      assert_equal(true, var_AST.VAR_QRES().pop().VAR_OBJECT())
      
      # float == float -> true
      equalExpression = EqualExpression.new(FloatTerminal.new(123.883), FloatTerminal.new(123.883))
      equalExpression.execute(var_AST)
      
      assert_equal(true, var_AST.VAR_QRES().pop().VAR_OBJECT())
      
      # float == float -> false
      equalExpression = EqualExpression.new(FloatTerminal.new(123.883), FloatTerminal.new(123.882))
      equalExpression.execute(var_AST)
      
      assert_equal(false, var_AST.VAR_QRES().pop().VAR_OBJECT())
      
      # float == integer -> true
      equalExpression = EqualExpression.new(FloatTerminal.new(123.00), IntegerTerminal.new(123))
      equalExpression.execute(var_AST)
      
      assert_equal(true, var_AST.VAR_QRES().pop().VAR_OBJECT())
      
      # float == float -> false
      equalExpression = EqualExpression.new(FloatTerminal.new(123.00), FloatTerminal.new(123.01))
      equalExpression.execute(var_AST)
      
      assert_equal(false, var_AST.VAR_QRES().pop().VAR_OBJECT())    

      # integer == integer -> true
      equalExpression = EqualExpression.new(IntegerTerminal.new(123), IntegerTerminal.new(123))
      equalExpression.execute(var_AST)

      assert_equal(true, var_AST.VAR_QRES().pop().VAR_OBJECT())    
        
      # integer == float -> true
      equalExpression = EqualExpression.new(IntegerTerminal.new(123), FloatTerminal.new(123.00))
      equalExpression.execute(var_AST)
      
      assert_equal(true, var_AST.VAR_QRES().pop().VAR_OBJECT())
      
      # integer == float -> false
      equalExpression = EqualExpression.new(IntegerTerminal.new(123), FloatTerminal.new(123.01))
      equalExpression.execute(var_AST)
      
      assert_equal(false, var_AST.VAR_QRES().pop().VAR_OBJECT())    
      
      # string == string -> true
      equalExpression = EqualExpression.new(StringTerminal.new("123"), StringTerminal.new("123"))
      equalExpression.execute(var_AST)

      assert_equal(true, var_AST.VAR_QRES().pop().VAR_OBJECT())    
      }  
    end
    
    # Tests for 'greather' expression
    #
    # Params:
    #
    # Returns:
    #
    # Throws:   
    def test_greatherExpression
      
      # Set debug log level
      Common::Logger.setLogLevel(Common::VAR_DEBUG)   
      
      assert_nothing_thrown("Creating AST objects") { 
        
      var_AST = AST.new("sampledata/data.xml")
 
      # float > float -> false
      greatherExpression = GreatherExpression.new(FloatTerminal.new(123.883), FloatTerminal.new(123.883))
      greatherExpression.execute(var_AST)
      
      assert_equal(false, var_AST.VAR_QRES().pop().VAR_OBJECT())
      
      # float > float -> true
      greatherExpression = GreatherExpression.new(FloatTerminal.new(123.883), FloatTerminal.new(123.882))
      greatherExpression.execute(var_AST)
      
      assert_equal(true, var_AST.VAR_QRES().pop().VAR_OBJECT())
      
      # float > integer -> true
      greatherExpression = GreatherExpression.new(FloatTerminal.new(123.01), IntegerTerminal.new(123))
      greatherExpression.execute(var_AST)
      
      assert_equal(true, var_AST.VAR_QRES().pop().VAR_OBJECT())
      
      # float > float -> false
      greatherExpression = GreatherExpression.new(FloatTerminal.new(122.99), FloatTerminal.new(123.00))
      greatherExpression.execute(var_AST)
      
      assert_equal(false, var_AST.VAR_QRES().pop().VAR_OBJECT())    

      # integer > integer -> true
      greatherExpression = GreatherExpression.new(IntegerTerminal.new(124), IntegerTerminal.new(123))
      greatherExpression.execute(var_AST)

      assert_equal(true, var_AST.VAR_QRES().pop().VAR_OBJECT())    
        
      # integer > float -> true
      greatherExpression = GreatherExpression.new(IntegerTerminal.new(124), FloatTerminal.new(123.00))
      greatherExpression.execute(var_AST)
      
      assert_equal(true, var_AST.VAR_QRES().pop().VAR_OBJECT())
      
      # integer > float -> false
      greatherExpression = GreatherExpression.new(IntegerTerminal.new(123), FloatTerminal.new(123.01))
      greatherExpression.execute(var_AST)
      
      assert_equal(false, var_AST.VAR_QRES().pop().VAR_OBJECT())    
      
      # string > string -> false
      greatherExpression = GreatherExpression.new(StringTerminal.new("123"), StringTerminal.new("123"))
      greatherExpression.execute(var_AST)

      assert_equal(false, var_AST.VAR_QRES().pop().VAR_OBJECT())    
      } 
    end
    
    # Tests for 'greather equal' expression
    #
    # Params:
    #
    # Returns:
    #
    # Throws:   
    def test_greatherEqualExpression
      
      # Set debug log level
      Common::Logger.setLogLevel(Common::VAR_DEBUG)   
      
      assert_nothing_thrown("Creating AST objects") { 
        
      var_AST = AST.new("sampledata/data.xml")
 
      # float >= float -> true
      greatherEqualExpression = GreatherEqualExpression.new(FloatTerminal.new(123.883), FloatTerminal.new(123.883))
      greatherEqualExpression.execute(var_AST)
      
      assert_equal(true, var_AST.VAR_QRES().pop().VAR_OBJECT())
      
      # float >= float -> true
      greatherEqualExpression = GreatherEqualExpression.new(FloatTerminal.new(123.883), FloatTerminal.new(123.882))
      greatherEqualExpression.execute(var_AST)
      
      assert_equal(true, var_AST.VAR_QRES().pop().VAR_OBJECT())
      
      # float >= integer -> true
      greatherEqualExpression = GreatherEqualExpression.new(FloatTerminal.new(123.01), IntegerTerminal.new(123))
      greatherEqualExpression.execute(var_AST)
      
      assert_equal(true, var_AST.VAR_QRES().pop().VAR_OBJECT())
      
      # float >= float -> false
      greatherEqualExpression = GreatherEqualExpression.new(FloatTerminal.new(122.99), FloatTerminal.new(123.00))
      greatherEqualExpression.execute(var_AST)
      
      assert_equal(false, var_AST.VAR_QRES().pop().VAR_OBJECT())    

      # integer >= integer -> true
      greatherEqualExpression = GreatherEqualExpression.new(IntegerTerminal.new(124), IntegerTerminal.new(123))
      greatherEqualExpression.execute(var_AST)

      assert_equal(true, var_AST.VAR_QRES().pop().VAR_OBJECT())    
        
      # integer >= float -> true
      greatherEqualExpression = GreatherEqualExpression.new(IntegerTerminal.new(124), FloatTerminal.new(123.00))
      greatherEqualExpression.execute(var_AST)
      
      assert_equal(true, var_AST.VAR_QRES().pop().VAR_OBJECT())
      
      # integer >= float -> false
      greatherEqualExpression = GreatherEqualExpression.new(IntegerTerminal.new(123), FloatTerminal.new(123.01))
      greatherEqualExpression.execute(var_AST)
      
      assert_equal(false, var_AST.VAR_QRES().pop().VAR_OBJECT())    
      
      # string >= string -> true
      greatherEqualExpression = GreatherEqualExpression.new(StringTerminal.new("123"), StringTerminal.new("123"))
      greatherEqualExpression.execute(var_AST)

      assert_equal(true, var_AST.VAR_QRES().pop().VAR_OBJECT())    
      } 
    end

    # Tests for 'less' expression
    #
    # Params:
    #
    # Returns:
    #
    # Throws:   
    def test_lessExpression
      
      # Set debug log level
      Common::Logger.setLogLevel(Common::VAR_DEBUG)   
      
      assert_nothing_thrown("Creating AST objects") { 
        
      var_AST = AST.new("sampledata/data.xml")
 
      # float < float -> true
      expression = LessExpression.new(FloatTerminal.new(123.882), FloatTerminal.new(123.883))
      expression.execute(var_AST)

      assert_equal(true, var_AST.VAR_QRES().pop().VAR_OBJECT())
      
      # float < float -> true
      expression = LessExpression.new(FloatTerminal.new(123.881), FloatTerminal.new(123.882))
      expression.execute(var_AST)
      
      assert_equal(true, var_AST.VAR_QRES().pop().VAR_OBJECT())
      
      # float < integer -> true
      expression = LessExpression.new(FloatTerminal.new(122.999), IntegerTerminal.new(123))
      expression.execute(var_AST)
      
      assert_equal(true, var_AST.VAR_QRES().pop().VAR_OBJECT())
      
      # float < float -> false
      expression = LessExpression.new(FloatTerminal.new(123.00), FloatTerminal.new(123.00))
      expression.execute(var_AST)
      
      assert_equal(false, var_AST.VAR_QRES().pop().VAR_OBJECT())    

      # integer < integer -> true
      expression = LessExpression.new(IntegerTerminal.new(122), IntegerTerminal.new(123))
      expression.execute(var_AST)

      assert_equal(true, var_AST.VAR_QRES().pop().VAR_OBJECT())    
        
      # integer < float -> true
      expression = LessExpression.new(IntegerTerminal.new(123), FloatTerminal.new(123.001))
      expression.execute(var_AST)
      
      assert_equal(true, var_AST.VAR_QRES().pop().VAR_OBJECT())
      
      # integer < float -> false
      expression = LessExpression.new(IntegerTerminal.new(123), FloatTerminal.new(123.00))
      expression.execute(var_AST)
      
      assert_equal(false, var_AST.VAR_QRES().pop().VAR_OBJECT())    
      
      # string < string -> true
      expression = LessExpression.new(StringTerminal.new("12"), StringTerminal.new("123"))
      expression.execute(var_AST)

      assert_equal(true, var_AST.VAR_QRES().pop().VAR_OBJECT())    
      } 
    end
    
    # Tests for 'less equal' expression
    #
    # Params:
    #
    # Returns:
    #
    # Throws:   
    def test_lessEqualExpression
      
      # Set debug log level
      Common::Logger.setLogLevel(Common::VAR_DEBUG)   
      
      assert_nothing_thrown("Creating AST objects") { 
        
      var_AST = AST.new("sampledata/data.xml")
 
      # float <= float -> true
      expression = LessEqualExpression.new(FloatTerminal.new(123.882), FloatTerminal.new(123.883))
      expression.execute(var_AST)
      
      assert_equal(true, var_AST.VAR_QRES().pop().VAR_OBJECT())
      
      # float <= float -> true
      expression = LessEqualExpression.new(FloatTerminal.new(123.882), FloatTerminal.new(123.882))
      expression.execute(var_AST)
      
      assert_equal(true, var_AST.VAR_QRES().pop().VAR_OBJECT())
      
      # float <= integer -> true
      expression = LessEqualExpression.new(FloatTerminal.new(123.00), IntegerTerminal.new(123))
      expression.execute(var_AST)
      
      assert_equal(true, var_AST.VAR_QRES().pop().VAR_OBJECT())
      
      # float <= float -> false
      expression = LessEqualExpression.new(FloatTerminal.new(123.0001), FloatTerminal.new(123.0000))
      expression.execute(var_AST)
      
      assert_equal(false, var_AST.VAR_QRES().pop().VAR_OBJECT())    

      # integer <= integer -> true
      expression = LessEqualExpression.new(IntegerTerminal.new(123), IntegerTerminal.new(123))
      expression.execute(var_AST)

      assert_equal(true, var_AST.VAR_QRES().pop().VAR_OBJECT())    
        
      # integer <= float -> true
      expression = LessEqualExpression.new(IntegerTerminal.new(123), FloatTerminal.new(123.00))
      expression.execute(var_AST)
      
      assert_equal(true, var_AST.VAR_QRES().pop().VAR_OBJECT())
      
      # integer <= float -> false
      expression = LessEqualExpression.new(IntegerTerminal.new(123), FloatTerminal.new(122.99901))
      expression.execute(var_AST)
      
      assert_equal(false, var_AST.VAR_QRES().pop().VAR_OBJECT())    
      
      # string <= string -> true
      expression = LessEqualExpression.new(StringTerminal.new("12"), StringTerminal.new("123"))
      expression.execute(var_AST)

      assert_equal(true, var_AST.VAR_QRES().pop().VAR_OBJECT())    
      } 
    end
    
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
        integerTerminal = IntegerTerminal.new(123)
        floatTerminal = FloatTerminal.new(788.231)
        booleanTerminal = BooleanTerminal.new(false)
    
        var_AST = AST.new("sampledata/data.xml")

        integerTerminal.execute(var_AST)
        floatTerminal.execute(var_AST)
        
        plusExpression = PlusExpression.new(PlusExpression.new(stringTerminal, floatTerminal), integerTerminal)
        plusExpression.execute(var_AST)
        
        minusExpression = MinusExpression.new(floatTerminal, integerTerminal)
        minusExpression.execute(var_AST)
        
        multiplyExpression = MultiplyExpression.new(floatTerminal, integerTerminal)
        multiplyExpression.execute(var_AST)
        
        divideExpression = DivideExpression.new(integerTerminal, floatTerminal)
        divideExpression.execute(var_AST)
        }
    end
  end
end
