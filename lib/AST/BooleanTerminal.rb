module AST
  
require "lib/AST/IncorrectArgumentException"

require "lib/QRES/BooleanResult"
require "lib/AST/TerminalExpression"


  class BooleanTerminal < TerminalExpression
    
    # Params:
    #
    # var_Value:TrueClass/FalseClass
    #
    # Returns:
    #
    # Throws:
    def initialize(var_Value)
      if(!var_Value.is_a?(TrueClass) && !var_Value.is_a?(FalseClass))
        raise IncorrectArgumentException.new("Incorrect argument type [#{var_Value.class.to_s()}], expected [Boolean]")
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
      
      var_AST.booleanTerminalExec(self)
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[execute]: Done.")
    end
        
    # Casts current object value into QRES object.
    #
    # Params:
    #
    # Returns:AbstractQueryResult
    #
    # Throws:    
    def to_qres()
      return QRES::BooleanResult.new(self.VAR_VALUE)
    end
  end
end
