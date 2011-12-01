module AST
  
require "lib/AST/IncorrectArgumentException"


  class StringTerminal < TerminalExpression
    
    # Params:
    #
    # var_Value:String
    #
    # Returns:
    #
    # Throws:
    def initialize(var_Value)
      if(!var_Value.is_a?(String))
        raise IncorrectArgumentException.new("Incorrect argument type [#{var_Value.class.to_s()}], expected [#{String.class.to_s()}]")
      end
      
      super(var_Value)
    end
  end
end