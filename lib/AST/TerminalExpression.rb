module AST
  
require "lib/AST/Expression"


  # Abstract class for terminal expressions
  class TerminalExpression < Expression
    
    # Params:
    #
    # var_Value:Array - expressions
    #
    # Returns:
    #
    # Throws:    
     def initialize(var_Value)
       super(var_Value)
     end    
  end
end