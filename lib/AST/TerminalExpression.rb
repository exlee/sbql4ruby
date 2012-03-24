module AST
  
require "lib/AST/Expression"


  # Class: TerminalExpression
  # Extends: Expression
  #
  # Abstract class for terminal expressions
  class TerminalExpression < Expression
    
    # Method: initialize (constructor)
    #
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
    
    # Method: execute
    #
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
    
    # Method: to_qres
    #
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
