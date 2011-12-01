module AST
  
require "lib/AST/IncorrectArgumentException"


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
  end
end