module Operator

require "lib/Operator/AbstractOperator"  
require "lib/Operator/RuntimeException"

require "lib/QRES/BinderResult"
require "lib/QRES/Utils"

  
  class GroupAs < AbstractOperator
    
    # Evaluates 'groupas' operator 
    #
    # Params:
    #
    # var_Value:AbstractQueryResult - expression to be executed
 
    # var_AST:AST - AST visitor
    #
    # Throws:
    def GroupAs.eval(var_Value, var_Name, var_AST)

      Common::Logger.print(Common::VAR_DEBUG, self, "[groupas]: Beginning operation for object name [#{var_Value.to_s()}]")
      Common::Logger.print(Common::VAR_DEBUG, self, "[groupas]: #{var_AST.VAR_QRES().to_s()}\n#{var_AST.VAR_ENVS().to_s()}")

      # Evaluating expression
      var_Value.execute(var_AST)
      
      var_ExpressionResult = var_AST.VAR_QRES().pop()
          
      Common::Logger.print(Common::VAR_DEBUG, self, "[groupas]: Operator call in context of simple object type: [#{var_ExpressionResult.to_s()}]")
         
      var_AST.VAR_QRES().push(QRES::BinderResult.new(var_Name, var_ExpressionResult))         
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[groupas]: After operation\n#{var_AST.VAR_QRES().to_s()}\n#{var_AST.VAR_ENVS().to_s()}")    
    end
  end
end