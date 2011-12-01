module AST
  
require "lib/AST/IncorrectArgumentException"


  class IntegerTerminal < TerminalExpression
    
    # Params:
    #
    # var_Value:Integer
    #
    # Returns:
    #
    # Throws:
    def initialize(var_Value)
      if(!var_Value.is_a?(Integer))
        raise IncorrectArgumentException.new("Incorrect argument type [#{var_Value.class.to_s()}], expected [#{Integer.class.to_s()}]")
      end
      
      super(var_Value)
    end
  end
end