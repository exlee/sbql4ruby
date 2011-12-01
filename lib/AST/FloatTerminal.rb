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
  end
end