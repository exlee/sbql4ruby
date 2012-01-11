module Operator

require "lib/Operator/AbstractOperator"  
require "lib/Operator/Evaluate"

require "lib/QRES/BagResult"  
require "lib/QRES/StructResult"  

  
  class Bag < AbstractOperator
    
    # Evaluates 'bag' operator 
    #
    # Params:
    #
    # var_Value:AbstractQueryResult - expression to be executed
 
    # var_AST:AST - AST visitor
    #
    # Throws:
    def Bag.eval(var_Value, var_AST)

      Common::Logger.print(Common::VAR_DEBUG, self, "[bag]: Beginning operation for object name [#{var_Value.to_s()}]")
      Common::Logger.print(Common::VAR_DEBUG, self, "[bag]: #{var_AST.VAR_QRES().to_s()}\n#{var_AST.VAR_ENVS().to_s()}")

      # Evaluating the right side if the expression
      var_Value.execute(var_AST)
      var_ExpressionResult = var_AST.VAR_QRES().pop()
      
      var_StructResult = QRES::StructResult.new()
      var_StructResult.push(var_ExpressionResult)
      
      var_BagResult = QRES::BagResult.new()
      var_BagResult.push(var_StructResult)
      
      var_AST.VAR_QRES().push(var_BagResult)

      Common::Logger.print(Common::VAR_DEBUG, self, "[bag]: After operation, object name [#{var_Value.to_s()}]")
      Common::Logger.print(Common::VAR_DEBUG, self, "[bag]: #{var_AST.VAR_QRES().to_s()}\n#{var_AST.VAR_ENVS().to_s()}")    
    end
  end
end