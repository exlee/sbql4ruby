module AST
  
require "lib/AST/IncorrectArgumentException"

require "lib/QRES/FloatResult"


  # Class: FloatTerminal
  # Extends: TerminalExpression
  #
  # Class representing Terminal in Float form
  class FloatTerminal < TerminalExpression
    
    # Method: initialize (constructor)
    # 
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
    
    # Method: execute
    #
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
      
     var_AST.floatTerminalExec(self)
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[execute]: Done.")
    end
    
    # Method: to_qres
    #
    # Casts current object value into QRES object.
    #
    # Params:
    #
    # Returns:AbstractQueryResult
    #
    # Throws:    
    def to_qres()
      return QRES::FloatResult.new(self.VAR_VALUE)
    end
  end
end
