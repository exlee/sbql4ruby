module AST

require "lib/AST/BinaryExpression"
  

  # Class: LessExpression
  # Extends: BinaryExpression
  #
  # Class implementing Less expression
  class LessExpression < BinaryExpression

    # Method: initialize (constructor)
    # Params:
    #
    # var_LeftExpression:Expression - L-Value
    #
    # var_RightExpression:Expression - R-Value
    #
    # Returns:
    #
    # Throws: 
    def initialize(var_LeftExpression, var_RightExpression)
      super(var_LeftExpression, var_RightExpression)
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
      puts "\n\n NIE DUPA!!!"
      var_AST.lessExpressionExec(self)
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[execute]: Done.")
    end
  end
end
