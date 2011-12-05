module QRES

require "lib/QRES/IntegerResult"  
require "lib/QRES/FloatResult"

require "lib/AST/IntegerTerminal"
require "lib/AST/FloatTerminal"

require "lib/QRES/IncorrectArgumentException"


  class QRESObjectFactory
    
    # Casts given AST object to QRES object 
    #
    # Params:
    # 
    # var_Object:Expression - An object taken from AST to be executed
    #
    # Returns:AbstractQueryResult
    #
    # Throws: IncorrectArgumentException
    def QRESObjectFactory.castFromAST(var_Expression)
      if(var_Expression.is_a?(AST::IntegerTerminal))
        return IntegerResult.new(var_Expression.VAR_VALUE())
      elsif(var_Expression.is_a?(AST::FloatTerminal)) 
        return FloatResult.new(var_Expression.VAR_VALUE())
      else
         raise IncorrectArgumentException.new("Incorrect argument type [#{var_Expression.class.to_s()}], expected [Expression]")
      end
    end
  end
end