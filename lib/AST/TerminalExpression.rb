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
    
    # Abstract method, should be implemented by the inheriting 
    # classes (valids given object).
    #
    # Params:
    #
    # Returns:
    #
    # Throws: AbstractMethodExcepion
    def execute(var_AST)
      raise AbstractMethodExcepion.new("Abstract method")
    end   
    
    # Abstract method, should be implemented by the inheriting 
    # classes (valids given object).
    # Params:
    #
    # Returns:
    #
    # Throws:AbstractMethodExcepion    
    def to_qres()
      raise AbstractMethodExcepion.new("Abstract method")
    end 
  end
end