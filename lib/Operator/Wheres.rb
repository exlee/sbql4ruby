module Operator

require "lib/Operator/AbstractOperator"  
require "lib/Operator/Evaluate"

require "lib/QRES/BagResult"  
  
  class Wheres < AbstractOperator
    
    # Evaluates 'wheres' operator 
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
    def Wheres.eval(var_LValue, var_RValue, var_AST)

      Common::Logger.print(Common::VAR_DEBUG, self, 
          "[wheres]: Beginning operation for object name [#{var_LValue.to_s()}], attribute name [#{var_RValue.to_s()}]")
      Common::Logger.print(Common::VAR_DEBUG, self, "[wheres]: #{var_AST.VAR_QRES().to_s()}\n#{var_AST.VAR_ENVS().to_s()}")

      # Evaluating the right side if the expression
      var_AST.VAR_QRES().push(var_LValue.wheres(var_RValue, var_AST))

      Common::Logger.print(Common::VAR_DEBUG, self, "[wheres]: After operation, object name [#{var_LValue.to_s()}], attribute name [#{var_RValue.to_s()}]")
      Common::Logger.print(Common::VAR_DEBUG, self, "[wheres]: #{var_AST.VAR_QRES().to_s()}\n#{var_AST.VAR_ENVS().to_s()}")    
    end
  end
end