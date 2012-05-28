module Operator

require "lib/Operator/AbstractOperator"  
require "lib/Operator/Evaluate"

require "lib/QRES/BagResult"

  
  class OrderBy < AbstractOperator
    
    # Evaluates 'order  by' operator 
    #
    # Params:
    #
    # var_LValue:AbstractQueryResult - left side of expression
    #
    # var_RValue:AbstractQueryResult - right side of expression
    #
    # var_AST:AST - AST visitor
    #
    # Throws:
    def OrderBy.eval(var_LValue, var_RValue, var_AST)
      
      Common::Logger.print(Common::VAR_DEBUG, self, 
        "[order by]: Beginning operation for object name [#{var_LValue.to_s()}], attribute name [#{var_RValue.to_s()}]")
      Common::Logger.print(Common::VAR_DEBUG, self, "[order by]: #{var_AST.VAR_QRES().to_s()}\n#{var_AST.VAR_ENVS().to_s()}")

      Join.eval(var_LValue, var_RValue, var_AST)
      
      var_BagResult = var_AST.VAR_QRES().pop()
      
      var_Array = var_BagResult.VAR_OBJECT().VAR_STACK()
      
      var_Array.sort!{|a1, a2| a1.compare(a2, var_AST)}
      
      #var_AST.VAR_QRES().push(bagResult)

      Common::Logger.print(Common::VAR_DEBUG, self, "[order by]: After operation, object name [#{var_LValue.to_s()}], attribute name [#{var_RValue.to_s()}]")
      Common::Logger.print(Common::VAR_DEBUG, self, "[order by]: #{var_AST.VAR_QRES().to_s()}\n#{var_AST.VAR_ENVS().to_s()}")    
    end
  end
end