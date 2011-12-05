module AST
  
require "lib/AST/AST"

require "lib/AST/IntegerTerminal"  

  
  class Utils
    
    def Utils.execute(var_Expression, var_AST)
      if(!var_AST.is_a?(AST))
        raise IncorrectArgumentException.new("Incorrect argument type [#{var_AST.class.to_s()}], expected [#{AST.class.to_s()}]")
      end
      
      if(var_Expression.is_a?(IntegerTerminal))
        var_AST.integerTerminalExec(var_Expression)
      elsif(var_Expression.is_a?(FloatTerminal))
        var_AST.floatTerminalExec(var_Expression)
      else
        raise IncorrectArgumentException.new("Incorrect argument type [#{var_Expression.class.to_s()}], expected [#{Expression.class.to_s()}]")
      end
    end
  end
end