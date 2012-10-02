module Operator

require "lib/Operator/AbstractOperator"  
require "lib/Operator/Evaluate"

require "lib/QRES/BagResult"  
require "lib/QRES/StructResult"  

  
  class PickRandom < AbstractOperator
    
    # Evaluates 'pick random' operator 
    #
    # Params:
    #
    # var_Value:AbstractQueryResult - expression to be executed
 
    # var_AST:AST - AST visitor
    #
    # Throws:
    def PickRandom.eval(var_Value, var_AST)

      Common::Logger.print(Common::VAR_DEBUG, self, "[pickRandom]: Beginning operation for object name [#{var_Value.to_s()}]")
      Common::Logger.print(Common::VAR_DEBUG, self, "[pickRandom]: #{var_AST.VAR_QRES().to_s()}\n#{var_AST.VAR_ENVS().to_s()}")

      # Evaluating the right side of the expression
      var_Value.execute(var_AST)
      var_ExpressionResult = var_AST.VAR_QRES().pop()
      
      if(!var_ExpressionResult.is_a?(QRES::BagResult) && !var_ExpressionResult.is_a?(QRES::StructResult))
        raise RuntimeException.new("Incorrect object type [#{var_Object.class.to_s()}], " + QRES::BagResult.to_s() + " or " + QRES::StructResult.to_s() + " expected")      
      end
      
      var_AST.VAR_QRES().push(var_ExpressionResult.pickRandom(var_AST))

      Common::Logger.print(Common::VAR_DEBUG, self, "[bag]: After operation, object name [#{var_Value.to_s()}]")
      Common::Logger.print(Common::VAR_DEBUG, self, "[bag]: #{var_AST.VAR_QRES().to_s()}\n#{var_AST.VAR_ENVS().to_s()}")    
    end
  end
end