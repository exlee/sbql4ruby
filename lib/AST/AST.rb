module AST
  
require "lib/AST/IncorrectArgumentException"

require "lib/XMLDB/XMLParser"
require "lib/SBAStore/SBAStore"
require "lib/QRES/QRES"
require "lib/ENVS/ENVS"

require "lib/AST/IntegerTerminal"
require "lib/AST/FloatTerminal"

require "lib/QRES/IntegerResult"
require "lib/QRES/ReferenceResult"

require "lib/Operator/Plus"
require "lib/Operator/Minus"
require "lib/Operator/Multiply"
require "lib/Operator/Divide"
require "lib/Operator/Equal"
require "lib/Operator/Greather"
require "lib/Operator/GreatherEqual"
require "lib/Operator/Less"
require "lib/Operator/LessEqual"
require "lib/Operator/Different"
require "lib/Operator/Modulo"
require "lib/Operator/Or"
require "lib/Operator/And"
require "lib/Operator/Evaluate"
require "lib/Operator/Dotres"
require "lib/Operator/Wheres"


  class AST
    
    # Params:
    #
    # var_XMLDataPath:String - Path to data file
    # 
    # Returns:
    #
    # Throws:IncorrectArgumentException
    def initialize(var_XMLDataPath)
      
      if(!var_XMLDataPath.is_a?(String))
        raise IncorrectArgumentException.new("Incorrect object type [#{var_XMLDataPath.class.to_s()}], " + String.to_s() + " expected")
      end
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[initalize]: Initialising for arguments: [#{var_XMLDataPath}]")
      Common::Logger.print(Common::VAR_DEBUG, self, "[initalize]: Object initialised, stacks dump:")
      Common::Logger.print(Common::VAR_DEBUG, self, "[initalize]: #{@VAR_QRES.to_s()}\n#{@VAR_ENVS.to_s()}")
      
      var_parser = XMLDB::XMLParser.new()
      
      @VAR_STORE = var_parser.loadXML(var_XMLDataPath)
      @VAR_ENVS  = ENVS::ENVS.new(@VAR_STORE)
      @VAR_QRES  = QRES::QRES.new()
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[initalize]: Object initialised, stacks dump:")
      Common::Logger.print(Common::VAR_DEBUG, self, "[initalize]: #{@VAR_QRES.to_s()}\n#{@VAR_ENVS.to_s()}")
    end
    
    # Executes AST object 
    #
    # Params:
    #
    # var_Object:Expression - An object taken from AST to be executed
    #
    # Returns:
    #
    # Throws: IncorrectArgumentException
    def integerTerminalExec(var_Object)
      
      if(!var_Object.is_a?(IntegerTerminal))
        raise IncorrectArgumentException.new("Incorrect object type [#{var_Object.class.to_s()}], " + IntegerTerminal.to_s() + " expected") 
      end
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[integerTerminalExec]: Executing for arguments: [#{var_Object.to_s()}], stacks dump:")
      Common::Logger.print(Common::VAR_DEBUG, self, "[integerTerminalExec]: #{@VAR_QRES.to_s()}\n#{@VAR_ENVS.to_s()}")      
      
      @VAR_QRES.push(var_Object.to_qres())
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[integerTerminalExec]: Execute finished, stacks dump:")
      Common::Logger.print(Common::VAR_DEBUG, self, "[integerTerminalExec]: #{@VAR_QRES.to_s()}\n#{@VAR_ENVS.to_s()}")
    end
    
    # Executes AST object 
    #
    # Params:
    #
    # var_Object:Expression - An object taken from AST to be executed
    #
    # Returns:
    #
    # Throws: IncorrectArgumentException
    def floatTerminalExec(var_Object)
      
      if(!var_Object.is_a?(FloatTerminal))
        raise IncorrectArgumentException.new("Incorrect object type [#{var_Object.class.to_s()}], " + FloatTerminal.to_s() + " expected") 
      end
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[floatTerminalExec]: Executing for arguments: [#{var_Object.to_s()}], stacks dump:")
      Common::Logger.print(Common::VAR_DEBUG, self, "[floatTerminalExec]: #{@VAR_QRES.to_s()}\n#{@VAR_ENVS.to_s()}")      
      
      @VAR_QRES.push(var_Object.to_qres())
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[floatTerminalExec]: Execute finished, stacks dump:")
      Common::Logger.print(Common::VAR_DEBUG, self, "[floatTerminalExec]: #{@VAR_QRES.to_s()}\n#{@VAR_ENVS.to_s()}")
    end

    # Executes AST object 
    #
    # Params:
    #
    # var_Object:Expression - An object taken from AST to be executed
    #
    # Returns:
    #
    # Throws: IncorrectArgumentException
    def booleanTerminalExec(var_Object)
      
      if(!var_Object.is_a?(BooleanTerminal))
        raise IncorrectArgumentException.new("Incorrect object type [#{var_Object.class.to_s()}], " + BooleanTerminal.to_s() + " expected") 
      end
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[booleanTerminalExec]: Executing for arguments: [#{var_Object.to_s()}], stacks dump:")
      Common::Logger.print(Common::VAR_DEBUG, self, "[booleanTerminalExec]: #{@VAR_QRES.to_s()}\n#{@VAR_ENVS.to_s()}")      
      
      @VAR_QRES.push(var_Object.to_qres())
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[booleanTerminalExec]: Execute finished, stacks dump:")
      Common::Logger.print(Common::VAR_DEBUG, self, "[booleanTerminalExec]: #{@VAR_QRES.to_s()}\n#{@VAR_ENVS.to_s()}")
    end
    
    # Executes AST object 
    #
    # Params:
    #
    # var_Object:Expression - An object taken from AST to be executed
    #
    # Returns:
    #
    # Throws: IncorrectArgumentException
    def stringTerminalExec(var_Object)
      
      if(!var_Object.is_a?(StringTerminal))
        raise IncorrectArgumentException.new("Incorrect object type [#{var_Object.class.to_s()}], " + StringTerminal.to_s() + " expected") 
      end
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[stringTerminalExec]: Executing for arguments: [#{var_Object.to_s()}], stacks dump:")
      Common::Logger.print(Common::VAR_DEBUG, self, "[stringTerminalExec]: #{@VAR_QRES.to_s()}\n#{@VAR_ENVS.to_s()}")      
      
      @VAR_QRES.push(var_Object.to_qres())
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[stringTerminalExec]: Execute finished, stacks dump:")
      Common::Logger.print(Common::VAR_DEBUG, self, "[stringTerminalExec]: #{@VAR_QRES.to_s()}\n#{@VAR_ENVS.to_s()}")
    end
        
    # Executes AST object 
    #
    # Params:
    #
    # var_Object:Expression - An object taken from AST to be executed
    #
    # Returns:
    #
    # Throws: IncorrectArgumentException
    def plusExpressionExec(var_Object)
      
      if(!var_Object.is_a?(PlusExpression))
        raise IncorrectArgumentException.new("Incorrect object type [#{var_Object.class.to_s()}], " + PlusExpression.to_s() + " expected") 
      end
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[plusExpressionExec]: Executing for arguments: [#{var_Object.to_s()}], stacks dump:")
      Common::Logger.print(Common::VAR_DEBUG, self, "[plusExpressionExec]: #{@VAR_QRES.to_s()}\n#{@VAR_ENVS.to_s()}")      
      
      var_Object.getLeftExpression().execute(self)
      var_Object.getRightExpression().execute(self)
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[plusExpressionExec]: #{@VAR_QRES.to_s()}\n#{@VAR_ENVS.to_s()}")  
      
      var_RightValue = @VAR_QRES.pop()
      var_LeftValue = @VAR_QRES.pop()
      
      Operator::Plus.eval(var_LeftValue, var_RightValue, @VAR_QRES, @VAR_ENVS, @VAR_STORE)
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[plusExpressionExec]: Execute finished, stacks dump:")
      Common::Logger.print(Common::VAR_DEBUG, self, "[plusExpressionExec]: #{@VAR_QRES.to_s()}\n#{@VAR_ENVS.to_s()}")
    end
    
    # Executes AST object 
    #
    # Params:
    #
    # var_Object:Expression - An object taken from AST to be executed
    #
    # Returns:
    #
    # Throws: IncorrectArgumentException
    def minusExpressionExec(var_Object)
      
      if(!var_Object.is_a?(MinusExpression))
        raise IncorrectArgumentException.new("Incorrect object type [#{var_Object.class.to_s()}], " + MinusExpression.to_s() + " expected") 
      end
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[minusExpressionExec]: Executing for arguments: [#{var_Object.to_s()}], stacks dump:")
      Common::Logger.print(Common::VAR_DEBUG, self, "[minusExpressionExec]: #{@VAR_QRES.to_s()}\n#{@VAR_ENVS.to_s()}")      
      
      var_Object.getLeftExpression().execute(self)
      var_Object.getRightExpression().execute(self)
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[minusExpressionExec]: #{@VAR_QRES.to_s()}\n#{@VAR_ENVS.to_s()}")  
      
      var_RightValue = @VAR_QRES.pop()
      var_LeftValue = @VAR_QRES.pop()
      
      Operator::Minus.eval(var_LeftValue, var_RightValue, @VAR_QRES, @VAR_ENVS, @VAR_STORE)
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[minusExpressionExec]: Execute finished, stacks dump:")
      Common::Logger.print(Common::VAR_DEBUG, self, "[minusExpressionExec]: #{@VAR_QRES.to_s()}\n#{@VAR_ENVS.to_s()}")
    end
    
    # Executes AST object 
    #
    # Params:
    #
    # var_Object:Expression - An object taken from AST to be executed
    #
    # Returns:
    #
    # Throws: IncorrectArgumentException
    def multiplyExpressionExec(var_Object)
      
      if(!var_Object.is_a?(MultiplyExpression))
        raise IncorrectArgumentException.new("Incorrect object type [#{var_Object.class.to_s()}], " + MultiplyExpression.to_s() + " expected") 
      end
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[multiplyExpressionExec]: Executing for arguments: [#{var_Object.to_s()}], stacks dump:")
      Common::Logger.print(Common::VAR_DEBUG, self, "[multiplyExpressionExec]: #{@VAR_QRES.to_s()}\n#{@VAR_ENVS.to_s()}")      
      
      var_Object.getLeftExpression().execute(self)
      var_Object.getRightExpression().execute(self)
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[multiplyExpressionExec]: #{@VAR_QRES.to_s()}\n#{@VAR_ENVS.to_s()}")  
      
      var_RightValue = @VAR_QRES.pop()
      var_LeftValue = @VAR_QRES.pop()
      
      Operator::Multiply.eval(var_LeftValue, var_RightValue, @VAR_QRES, @VAR_ENVS, @VAR_STORE)
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[multiplyExpressionExec]: Execute finished, stacks dump:")
      Common::Logger.print(Common::VAR_DEBUG, self, "[multiplyExpressionExec]: #{@VAR_QRES.to_s()}\n#{@VAR_ENVS.to_s()}")
    end
    
    # Executes AST object 
    #
    # Params:
    #
    # var_Object:Expression - An object taken from AST to be executed
    #
    # Returns:
    #
    # Throws: IncorrectArgumentException
    def divideExpressionExec(var_Object)
      
      if(!var_Object.is_a?(DivideExpression))
        raise IncorrectArgumentException.new("Incorrect object type [#{var_Object.class.to_s()}], " + DivideExpression.to_s() + " expected") 
      end
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[divideExpressionExec]: Executing for arguments: [#{var_Object.to_s()}], stacks dump:")
      Common::Logger.print(Common::VAR_DEBUG, self, "[divideExpressionExec]: #{@VAR_QRES.to_s()}\n#{@VAR_ENVS.to_s()}")      
      
      var_Object.getLeftExpression().execute(self)
      var_Object.getRightExpression().execute(self)
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[divideExpressionExec]: #{@VAR_QRES.to_s()}\n#{@VAR_ENVS.to_s()}")  
      
      var_RightValue = @VAR_QRES.pop()
      var_LeftValue = @VAR_QRES.pop()
      
      Operator::Divide.eval(var_LeftValue, var_RightValue, @VAR_QRES, @VAR_ENVS, @VAR_STORE)
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[divideExpressionExec]: Execute finished, stacks dump:")
      Common::Logger.print(Common::VAR_DEBUG, self, "[divideExpressionExec]: #{@VAR_QRES.to_s()}\n#{@VAR_ENVS.to_s()}")
    end

    # Executes AST object 
    #
    # Params:
    #
    # var_Object:Expression - An object taken from AST to be executed
    #
    # Returns:
    #
    # Throws: IncorrectArgumentException
    def equalExpressionExec(var_Object)
      
      if(!var_Object.is_a?(EqualExpression))
        raise IncorrectArgumentException.new("Incorrect object type [#{var_Object.class.to_s()}], " + EqualExpression.to_s() + " expected") 
      end
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[equalExpressionExec]: Executing for arguments: [#{var_Object.to_s()}], stacks dump:")
      Common::Logger.print(Common::VAR_DEBUG, self, "[equalExpressionExec]: #{@VAR_QRES.to_s()}\n#{@VAR_ENVS.to_s()}")      
      
      var_Object.getLeftExpression().execute(self)
      var_Object.getRightExpression().execute(self)
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[equalExpressionExec]: #{@VAR_QRES.to_s()}\n#{@VAR_ENVS.to_s()}")  
      
      var_RightValue = @VAR_QRES.pop()
      var_LeftValue = @VAR_QRES.pop()
      
      Operator::Equal.eval(var_LeftValue, var_RightValue, @VAR_QRES, @VAR_ENVS, @VAR_STORE)
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[equalExpressionExec]: Execute finished, stacks dump:")
      Common::Logger.print(Common::VAR_DEBUG, self, "[equalExpressionExec]: #{@VAR_QRES.to_s()}\n#{@VAR_ENVS.to_s()}")
    end    
    
    # Executes AST object 
    #
    # Params:
    #
    # var_Object:Expression - An object taken from AST to be executed
    #
    # Returns:
    #
    # Throws: IncorrectArgumentException
    def greatherExpressionExec(var_Object)

      if(!var_Object.is_a?(GreatherExpression))
        raise IncorrectArgumentException.new("Incorrect object type [#{var_Object.class.to_s()}], " + GreatherExpression.to_s() + " expected") 
      end
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[equalExpressionExec]: Executing for arguments: [#{var_Object.to_s()}], stacks dump:")
      Common::Logger.print(Common::VAR_DEBUG, self, "[equalExpressionExec]: #{@VAR_QRES.to_s()}\n#{@VAR_ENVS.to_s()}")      
      
      var_Object.getLeftExpression().execute(self)
      var_Object.getRightExpression().execute(self)
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[equalExpressionExec]: #{@VAR_QRES.to_s()}\n#{@VAR_ENVS.to_s()}")  
      
      var_RightValue = @VAR_QRES.pop()
      var_LeftValue = @VAR_QRES.pop()
      
      Operator::Greather.eval(var_LeftValue, var_RightValue, @VAR_QRES, @VAR_ENVS, @VAR_STORE)
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[equalExpressionExec]: Execute finished, stacks dump:")
      Common::Logger.print(Common::VAR_DEBUG, self, "[equalExpressionExec]: #{@VAR_QRES.to_s()}\n#{@VAR_ENVS.to_s()}")
    end
    
    # Executes AST object 
    #
    # Params:
    #
    # var_Object:Expression - An object taken from AST to be executed
    #
    # Returns:
    #
    # Throws: IncorrectArgumentException
    def greatherEqualExpressionExec(var_Object)
      
      if(!var_Object.is_a?(GreatherEqualExpression))
        raise IncorrectArgumentException.new("Incorrect object type [#{var_Object.class.to_s()}], " + GreatherEqualExpression.to_s() + " expected") 
      end
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[greatherEqualExpressionExec]: Executing for arguments: [#{var_Object.to_s()}], stacks dump:")
      Common::Logger.print(Common::VAR_DEBUG, self, "[greatherEqualExpressionExec]: #{@VAR_QRES.to_s()}\n#{@VAR_ENVS.to_s()}")      
      
      var_Object.getLeftExpression().execute(self)
      var_Object.getRightExpression().execute(self)
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[greatherEqualExpressionExec]: #{@VAR_QRES.to_s()}\n#{@VAR_ENVS.to_s()}")  
      
      var_RightValue = @VAR_QRES.pop()
      var_LeftValue = @VAR_QRES.pop()
      
      Operator::GreatherEqual.eval(var_LeftValue, var_RightValue, @VAR_QRES, @VAR_ENVS, @VAR_STORE)
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[greatherEqualExpressionExec]: Execute finished, stacks dump:")
      Common::Logger.print(Common::VAR_DEBUG, self, "[greatherEqualExpressionExec]: #{@VAR_QRES.to_s()}\n#{@VAR_ENVS.to_s()}")
    end
    
    # Executes AST object 
    #
    # Params:
    #
    # var_Object:Expression - An object taken from AST to be executed
    #
    # Returns:
    #
    # Throws: IncorrectArgumentException
    def lessExpressionExec(var_Object)
      
      if(!var_Object.is_a?(LessExpression))
        raise IncorrectArgumentException.new("Incorrect object type [#{var_Object.class.to_s()}], " + LessExpression.to_s() + " expected") 
      end
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[lessExpressionExec]: Executing for arguments: [#{var_Object.to_s()}], stacks dump:")
      Common::Logger.print(Common::VAR_DEBUG, self, "[lessExpressionExec]: #{@VAR_QRES.to_s()}\n#{@VAR_ENVS.to_s()}")      
      
      var_Object.getLeftExpression().execute(self)
      var_Object.getRightExpression().execute(self)
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[lessExpressionExec]: #{@VAR_QRES.to_s()}\n#{@VAR_ENVS.to_s()}")  
      
      var_RightValue = @VAR_QRES.pop()
      var_LeftValue = @VAR_QRES.pop()
      
      Operator::Less.eval(var_LeftValue, var_RightValue, @VAR_QRES, @VAR_ENVS, @VAR_STORE)
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[lessExpressionExec]: Execute finished, stacks dump:")
      Common::Logger.print(Common::VAR_DEBUG, self, "[lessExpressionExec]: #{@VAR_QRES.to_s()}\n#{@VAR_ENVS.to_s()}")
    end
    
    # Executes AST object 
    #
    # Params:
    #
    # var_Object:Expression - An object taken from AST to be executed
    #
    # Returns:
    #
    # Throws: IncorrectArgumentException
    def lessEqualExpressionExec(var_Object)
      
      if(!var_Object.is_a?(LessEqualExpression))
        raise IncorrectArgumentException.new("Incorrect object type [#{var_Object.class.to_s()}], " + LessEqualExpression.to_s() + " expected") 
      end
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[lessEqualExpressionExec]: Executing for arguments: [#{var_Object.to_s()}], stacks dump:")
      Common::Logger.print(Common::VAR_DEBUG, self, "[lessEqualExpressionExec]: #{@VAR_QRES.to_s()}\n#{@VAR_ENVS.to_s()}")      
      
      var_Object.getLeftExpression().execute(self)
      var_Object.getRightExpression().execute(self)
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[lessEqualExpressionExec]: #{@VAR_QRES.to_s()}\n#{@VAR_ENVS.to_s()}")  
      
      var_RightValue = @VAR_QRES.pop()
      var_LeftValue = @VAR_QRES.pop()
      
      Operator::LessEqual.eval(var_LeftValue, var_RightValue, @VAR_QRES, @VAR_ENVS, @VAR_STORE)
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[lessEqualExpressionExec]: Execute finished, stacks dump:")
      Common::Logger.print(Common::VAR_DEBUG, self, "[lessEqualExpressionExec]: #{@VAR_QRES.to_s()}\n#{@VAR_ENVS.to_s()}")
    end
    
    # Executes AST object 
    #
    # Params:
    #
    # var_Object:Expression - An object taken from AST to be executed
    #
    # Returns:
    #
    # Throws: IncorrectArgumentException
    def differentExpressionExec(var_Object)
      
      if(!var_Object.is_a?(DifferentExpression))
        raise IncorrectArgumentException.new("Incorrect object type [#{var_Object.class.to_s()}], " + DifferentExpression.to_s() + " expected") 
      end
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[differentExpressionExec]: Executing for arguments: [#{var_Object.to_s()}], stacks dump:")
      Common::Logger.print(Common::VAR_DEBUG, self, "[differentExpressionExec]: #{@VAR_QRES.to_s()}\n#{@VAR_ENVS.to_s()}")      
      
      var_Object.getLeftExpression().execute(self)
      var_Object.getRightExpression().execute(self)
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[differentExpressionExec]: #{@VAR_QRES.to_s()}\n#{@VAR_ENVS.to_s()}")  
      
      var_RightValue = @VAR_QRES.pop()
      var_LeftValue = @VAR_QRES.pop()
      
      Operator::Different.eval(var_LeftValue, var_RightValue, @VAR_QRES, @VAR_ENVS, @VAR_STORE)
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[differentExpressionExec]: Execute finished, stacks dump:")
      Common::Logger.print(Common::VAR_DEBUG, self, "[differentExpressionExec]: #{@VAR_QRES.to_s()}\n#{@VAR_ENVS.to_s()}")
    end
    
    # Executes AST object 
    #
    # Params:
    #
    # var_Object:Expression - An object taken from AST to be executed
    #
    # Returns:
    #
    # Throws: IncorrectArgumentException
    def moduloExpressionExec(var_Object)
      
      if(!var_Object.is_a?(ModuloExpression))
        raise IncorrectArgumentException.new("Incorrect object type [#{var_Object.class.to_s()}], " + ModuloExpression.to_s() + " expected") 
      end
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[moduloExpressionExec]: Executing for arguments: [#{var_Object.to_s()}], stacks dump:")
      Common::Logger.print(Common::VAR_DEBUG, self, "[moduloExpressionExec]: #{@VAR_QRES.to_s()}\n#{@VAR_ENVS.to_s()}")      
      
      var_Object.getLeftExpression().execute(self)
      var_Object.getRightExpression().execute(self)
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[moduloExpressionExec]: #{@VAR_QRES.to_s()}\n#{@VAR_ENVS.to_s()}")  
      
      var_RightValue = @VAR_QRES.pop()
      var_LeftValue = @VAR_QRES.pop()
      
      Operator::Modulo.eval(var_LeftValue, var_RightValue, @VAR_QRES, @VAR_ENVS, @VAR_STORE)
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[moduloExpressionExec]: Execute finished, stacks dump:")
      Common::Logger.print(Common::VAR_DEBUG, self, "[moduloExpressionExec]: #{@VAR_QRES.to_s()}\n#{@VAR_ENVS.to_s()}")
    end
    
    # Executes AST object 
    #
    # Params:
    #
    # var_Object:Expression - An object taken from AST to be executed
    #
    # Returns:
    #
    # Throws: IncorrectArgumentException
    def orExpressionExec(var_Object)
      
      if(!var_Object.is_a?(OrExpression))
        raise IncorrectArgumentException.new("Incorrect object type [#{var_Object.class.to_s()}], " + OrExpression.to_s() + " expected") 
      end
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[orExpressionExec]: Executing for arguments: [#{var_Object.to_s()}], stacks dump:")
      Common::Logger.print(Common::VAR_DEBUG, self, "[orExpressionExec]: #{@VAR_QRES.to_s()}\n#{@VAR_ENVS.to_s()}")      
      
      var_Object.getLeftExpression().execute(self)
      var_Object.getRightExpression().execute(self)
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[orExpressionExec]: #{@VAR_QRES.to_s()}\n#{@VAR_ENVS.to_s()}")  
      
      var_RightValue = @VAR_QRES.pop()
      var_LeftValue = @VAR_QRES.pop()
      
      Operator::Or.eval(var_LeftValue, var_RightValue, @VAR_QRES, @VAR_ENVS, @VAR_STORE)
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[orExpressionExec]: Execute finished, stacks dump:")
      Common::Logger.print(Common::VAR_DEBUG, self, "[orExpressionExec]: #{@VAR_QRES.to_s()}\n#{@VAR_ENVS.to_s()}")
    end
    
    # Executes AST object 
    #
    # Params:
    #
    # var_Object:Expression - An object taken from AST to be executed
    #
    # Returns:
    #
    # Throws: IncorrectArgumentException
    def andExpressionExec(var_Object)
      
      if(!var_Object.is_a?(AndExpression))
        raise IncorrectArgumentException.new("Incorrect object type [#{var_Object.class.to_s()}], " + AndExpression.to_s() + " expected") 
      end
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[andExpressionExec]: Executing for arguments: [#{var_Object.to_s()}], stacks dump:")
      Common::Logger.print(Common::VAR_DEBUG, self, "[andExpressionExec]: #{@VAR_QRES.to_s()}\n#{@VAR_ENVS.to_s()}")      
      
      var_Object.getLeftExpression().execute(self)
      var_Object.getRightExpression().execute(self)
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[andExpressionExec]: #{@VAR_QRES.to_s()}\n#{@VAR_ENVS.to_s()}")  
      
      var_RightValue = @VAR_QRES.pop()
      var_LeftValue = @VAR_QRES.pop()
      
      Operator::And.eval(var_LeftValue, var_RightValue, @VAR_QRES, @VAR_ENVS, @VAR_STORE)
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[andExpressionExec]: Execute finished, stacks dump:")
      Common::Logger.print(Common::VAR_DEBUG, self, "[andExpressionExec]: #{@VAR_QRES.to_s()}\n#{@VAR_ENVS.to_s()}")
    end
    
    # Executes AST object 
    #
    # Params:
    #
    # var_Object:Expression - An object taken from AST to be executed
    #
    # Returns:
    #
    # Throws: IncorrectArgumentException
    def nameExpressionExec(var_Object)

      if(!var_Object.is_a?(NameExpression))
        raise IncorrectArgumentException.new("Incorrect object type [#{var_Object.class.to_s()}], " + NameExpression.to_s() + " expected") 
      end
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[nameExpressionExec]: Executing for arguments: [#{var_Object.to_s()}], stacks dump:")
      Common::Logger.print(Common::VAR_DEBUG, self, "[nameExpressionExec]: #{@VAR_QRES.to_s()}\n#{@VAR_ENVS.to_s()}")      
      
      Operator::Evaluate.eval(var_Object.VAR_NAME(), @VAR_QRES, @VAR_ENVS)
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[nameExpressionExec]: Execute finished, stacks dump:")
      Common::Logger.print(Common::VAR_DEBUG, self, "[nameExpressionExec]: #{@VAR_QRES.to_s()}\n#{@VAR_ENVS.to_s()}")
    end
    
    # Executes AST object 
    #
    # Params:
    #
    # var_Object:Expression - An object taken from AST to be executed
    #
    # Returns:
    #
    # Throws: IncorrectArgumentException
    def dotExpressionExec(var_Object)
      
      if(!var_Object.is_a?(DotExpression))
        raise IncorrectArgumentException.new("Incorrect object type [#{var_Object.class.to_s()}], " + DotExpression.to_s() + " expected") 
      end
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[dotExpressionExec]: Executing for arguments: [#{var_Object.to_s()}], stacks dump:")
      Common::Logger.print(Common::VAR_DEBUG, self, "[dotExpressionExec]: #{@VAR_QRES.to_s()}\n#{@VAR_ENVS.to_s()}")      
      
      # Executing left query side
      var_Object.getLeftExpression().execute(self)
    
      #Getting results from QRES
      var_LeftValue = @VAR_QRES.pop()
      
      # Only BagResult and StructResult are supported here
      if(!var_LeftValue.is_a?(QRES::BagResult) && !var_LeftValue.is_a?(QRES::StructResult))
        raise DataTypeException.new(
          "Incorrect object type [#{evalBagResult.class}], #{QRES::BagResult.to_s()} or #{QRES::StructResult.to_s()} are expected")
      end
      
      Operator::Dotres.eval(var_LeftValue, var_Object.getRightExpression(), self)
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[dotExpressionExec]: Execute finished, stacks dump:")
      Common::Logger.print(Common::VAR_DEBUG, self, "[dotExpressionExec]: #{@VAR_QRES.to_s()}\n#{@VAR_ENVS.to_s()}")
    end
    
    # Executes AST object 
    #
    # Params:
    #
    # var_Object:Expression - An object taken from AST to be executed
    #
    # Returns:
    #
    # Throws: IncorrectArgumentException
    def whereExpressionExec(var_Object)
      
      if(!var_Object.is_a?(WhereExpression))
        raise IncorrectArgumentException.new("Incorrect object type [#{var_Object.class.to_s()}], " + WhereExpression.to_s() + " expected") 
      end
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[whereExpressionExec]: Executing for arguments: [#{var_Object.to_s()}], stacks dump:")
      Common::Logger.print(Common::VAR_DEBUG, self, "[whereExpressionExec]: #{@VAR_QRES.to_s()}\n#{@VAR_ENVS.to_s()}")      
      
      # Executing left query side
      var_Object.getLeftExpression().execute(self)
    
      #Getting results from QRES
      var_LeftValue = @VAR_QRES.pop()
      
      # Only BagResult and StructResult are supported here
      if(!var_LeftValue.is_a?(QRES::BagResult) && !var_LeftValue.is_a?(QRES::StructResult))
        raise DataTypeException.new(
          "Incorrect object type [#{evalBagResult.class}], #{QRES::BagResult.to_s()} or #{QRES::StructResult.to_s()} are expected")
      end
      
      Operator::Wheres.eval(var_LeftValue, var_Object.getRightExpression(), self)
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[whereExpressionExec]: Execute finished, stacks dump:")
      Common::Logger.print(Common::VAR_DEBUG, self, "[whereExpressionExec]: #{@VAR_QRES.to_s()}\n#{@VAR_ENVS.to_s()}")
    end
    
    attr_reader :VAR_QRES
    attr_reader :VAR_ENVS
    attr_reader :VAR_STORE
    
  end
end