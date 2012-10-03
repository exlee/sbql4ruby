module Operator

require "lib/Operator/AbstractOperator"  
require "lib/Operator/Evaluate"

  
  # Class: Comma
  # Extends: AbstractOperator
  #
  # Class which implements Comma operator
  class Comma < AbstractOperator
    
    # Static Method: eval
    #
    # Evaluates 'comma' operator 
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
    def Comma.eval(var_LValue, var_RValue, var_AST)

      Common::Logger.print(Common::VAR_DEBUG, self, 
          "[comma]: Beginning operation for lValue=[#{var_LValue.to_s()}], rValue=[#{var_RValue.to_s()}]")
      Common::Logger.print(Common::VAR_DEBUG, self, "[comma]: #{var_AST.VAR_QRES().to_s()}\n#{var_AST.VAR_ENVS().to_s()}")

      #operatorResult = QRES::BagResult.new()
      operatorResult = QRES::StructResult.new()
      
      # Evaluating the left side of the expression
      var_LValue.execute(var_AST)
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[comma]: lValue is executed, stacks dump:")
      Common::Logger.print(Common::VAR_DEBUG, self, "[comma]: #{var_AST.VAR_QRES().to_s()}\n#{var_AST.VAR_ENVS().to_s()}")
        
      var_LValue =  QRES::Utils.getSimpleObjectAsBagResult(var_AST.VAR_QRES().pop())
          
      Common::Logger.print(Common::VAR_DEBUG, self, "[comma]: lValue is executed, stacks dump:")
      Common::Logger.print(Common::VAR_DEBUG, self, "[comma]: #{var_AST.VAR_QRES().to_s()}\n#{var_AST.VAR_ENVS().to_s()}")
      
      # Evaluating the right side of the expression
      var_AST.VAR_QRES().push(var_LValue.comma(var_RValue, var_AST))

      Common::Logger.print(Common::VAR_DEBUG, self, "[comma]: After operation, object name [#{var_LValue.to_s()}], attribute name [#{var_RValue.to_s()}]")
      Common::Logger.print(Common::VAR_DEBUG, self, "[comma]: #{var_AST.VAR_QRES().to_s()}\n#{var_AST.VAR_ENVS().to_s()}")    
    end
  end
end
