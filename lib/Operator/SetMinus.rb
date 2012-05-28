module Operator
  
require "lib/Operator/AbstractOperator"  
require "lib/Operator/RuntimeException"

require "lib/QRES/BagResult"

require "lib/QRES/Utils"

  
  class SetMinus < AbstractOperator
    
    # Evaluates 'set minus' operator 
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
    def SetMinus.eval(var_LValue, var_RValue, var_AST) 
      Common::Logger.print(Common::VAR_DEBUG, self, 
        "[comma]: Beginning operation for lValue=[#{var_LValue.to_s()}], rValue=[#{var_RValue.to_s()}]")
      Common::Logger.print(Common::VAR_DEBUG, self, "[comma]: #{var_AST.VAR_QRES().to_s()}\n#{var_AST.VAR_ENVS().to_s()}")

      # Evaluating left side of the expression
      var_LValue.execute(var_AST)

      Common::Logger.print(Common::VAR_DEBUG, self, "[comma]: lValue is executed, stacks dump:")
      Common::Logger.print(Common::VAR_DEBUG, self, "[comma]: #{var_AST.VAR_QRES().to_s()}\n#{var_AST.VAR_ENVS().to_s()}")

      # Evaluating right side of the expression
      var_RValue.execute(var_AST)

      Common::Logger.print(Common::VAR_DEBUG, self, "[comma]: rValue is executed, stacks dump:")
      Common::Logger.print(Common::VAR_DEBUG, self, "[comma]: #{var_AST.VAR_QRES().to_s()}\n#{var_AST.VAR_ENVS().to_s()}")

      var_RValue = var_AST.VAR_QRES().pop()
      var_LValue = var_AST.VAR_QRES().pop()
      
      operatorResult = var_LValue.setMinus(var_RValue, var_AST)

      var_AST.VAR_QRES().push(operatorResult)
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[comma]: After operation, object name [#{var_LValue.to_s()}], attribute name [#{var_RValue.to_s()}]")
      Common::Logger.print(Common::VAR_DEBUG, self, "[comma]: #{var_AST.VAR_QRES().to_s()}\n#{var_AST.VAR_ENVS().to_s()}")
    end
  end
end