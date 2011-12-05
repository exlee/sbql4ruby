module AST
  
require "lib/AST/IncorrectArgumentException"

require "lib/XMLDB/XMLParser"
require "lib/SBAStore/SBAStore"
require "lib/QRES/QRES"
require "lib/ENVS/ENVS"

require "lib/AST/IntegerTerminal"
require "lib/AST/FloatTerminal"

require "lib/QRES/QRESObjectFactory"
require "lib/QRES/IntegerResult"


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
      
      @VAR_QRES.push(QRES::QRESObjectFactory.castFromAST(var_Object))
      
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
      
      @VAR_QRES.push(QRES::QRESObjectFactory.castFromAST(var_Object))
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[floatTerminalExec]: Execute finished, stacks dump:")
      Common::Logger.print(Common::VAR_DEBUG, self, "[floatTerminalExec]: #{@VAR_QRES.to_s()}\n#{@VAR_ENVS.to_s()}")
    end
  end
end