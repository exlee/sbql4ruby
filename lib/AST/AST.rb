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
  end
end