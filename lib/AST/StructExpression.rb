module AST

require "lib/AST/UnaryExpression"
  

  # Class: StructExpression
  # Extends: UnaryExpression
  #
  # Class implementing Struct expression
  class StructExpression < UnaryExpression

    # Method: initialize (constructor)
    #
    # Params:
    #
    # var_Expression:Expression - Expression
    #
    # Returns:
    #
    # Throws: 
    def initialize(var_Expression)
      super(var_Expression)
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
    # Throws:IncorrectArgumentException
    def execute(var_AST)
      if(!var_AST.is_a?(AST))
        raise IncorrectArgumentException.new("Incorrect argument type [#{var_AST.class.to_s()}], expected [AST]")
      end
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[execute]: Executing for arguments: [#{self.class.to_s()}], [#{var_AST.class.to_s()}]")
      
      var_AST.structExpressionExec(self)
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[execute]: Done.")
    end
  end
end
