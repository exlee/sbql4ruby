module AST
  
require "lib/AST/IncorrectArgumentException"


  class FloatTerminal < TerminalExpression
    
    # Params:
    #
    # var_Value:Float
    #
    # Returns:
    #
    # Throws:
    def initialize(var_Value)
      if(!var_Value.is_a?(Float))
        raise IncorrectArgumentException.new("Incorrect argument type [#{var_Value.class.to_s()}], expected [#{Float.class.to_s()}]")
      end
      
      super(var_Value)
    end
    
    # Executes current expression using given AST object.
    #
    # Params:
    #
    # var_AST:AST - AST object which executes current expression. 
    # Current expression invokes 'exec' method giving it selves
    # as attribute.
    #
    # Returns:
    #
    # Throws:
    def execute(var_AST)
      if(!var_AST.is_a?(AST))
        raise IncorrectArgumentException.new("Incorrect argument type [#{var_AST.class.to_s()}], expected [AST]")
      end
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[execute]: Executing for arguments: [#{self.class.to_s()}], [#{var_AST.class.to_s()}]")
      
      Utils.execute(self, var_AST)
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[execute]: Done.")
    end
  end
end