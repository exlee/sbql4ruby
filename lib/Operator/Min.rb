module Operator

require "lib/Operator/AbstractOperator"  
require "lib/Operator/RuntimeException"

require "lib/QRES/Utils"

  
  class Min < AbstractOperator
    
    # Evaluates 'min' operator 
    #
    # Params:
    #
    # var_Value:AbstractQueryResult - expression to be executed
 
    # var_AST:AST - AST visitor
    #
    # Throws:
    def Min.eval(var_Value, var_AST)

      Common::Logger.print(Common::VAR_DEBUG, self, "[min]: Beginning operation for object name [#{var_Value.to_s()}]")
      Common::Logger.print(Common::VAR_DEBUG, self, "[min]: #{var_AST.VAR_QRES().to_s()}\n#{var_AST.VAR_ENVS().to_s()}")

      # Evaluating the right side if the expression
      var_Value.execute(var_AST)
      
      var_ExpressionResult = QRES::Utils::dereference(var_AST.VAR_QRES().pop(), var_AST.VAR_STORE())
      
      if(QRES::Utils::isSimpleObject?(var_ExpressionResult))
        Common::Logger.print(Common::VAR_DEBUG, self, "[min]: Operator call in context of simple object type: [#{var_ExpressionResult.to_s()}]")
         
        var_AST.VAR_QRES().push(var_ExpressionResult)
      else
        Common::Logger.print(Common::VAR_DEBUG, self, "[min]: Operator call in context of complex object type: [#{var_ExpressionResult.to_s()}]")
        
        var_AST.VAR_QRES().push(var_ExpressionResult.min(var_AST.VAR_STORE()))
      end
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[min]: After operation, object name [#{var_Value.to_s()}]")
      Common::Logger.print(Common::VAR_DEBUG, self, "[min]: #{var_AST.VAR_QRES().to_s()}\n#{var_AST.VAR_ENVS().to_s()}")    
    end
  end
end