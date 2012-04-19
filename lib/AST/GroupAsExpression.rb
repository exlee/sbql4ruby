module AST

require "lib/AST/UnaryExpression"
  

  class GroupAsExpression < UnaryExpression

    # Params:
    #
    # var_Expression:Expression - Expression
    #
    # Returns:
    #
    # Throws: 
    def initialize(var_Expression, var_Name)
      if(var_Name == nil)
        IncorrectArgumentException.new("Incorrect argument 'VAR_NAME'=[#{var_Expression.class.to_s()}]")
      end
 
      @VAR_NAME = var_Name
      
      super(var_Expression)
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
    # Throws:IncorrectArgumentException
    def execute(var_AST)
      if(!var_AST.is_a?(AST))
        raise IncorrectArgumentException.new("Incorrect argument type [#{var_AST.class.to_s()}], expected [AST]")
      end
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[execute]: Executing for arguments: [#{self.class.to_s()}], [#{var_AST.class.to_s()}]")
      
      var_AST.groupAsExpressionExec(self)
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[execute]: Done.")
    end
    
    # Returns a string representation of AsExpression object.
    #
    # Params:
    #
    # Returns:String
    #
    # Throws:
    def to_s
      return self.class.to_s() + ", name=[#{@VAR_NAME}]"
    end
    
    # Getter and setter for VAR_NAME variable
    attr_accessor :VAR_NAME
    
  end
end