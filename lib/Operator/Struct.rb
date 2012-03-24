module Operator

require "lib/Operator/AbstractOperator"  
require "lib/Operator/Evaluate"

require "lib/QRES/BagResult"  
require "lib/QRES/StructResult"  

  
  # Class: Struct
  # Extends: AbstractOperator
  #
  # Class implementing Struct operator
  class Struct < AbstractOperator
    
    # Static Method: eval
    #
    # Evaluates 'struct' operator 
    #
    # Params:
    #
    # var_Value:AbstractQueryResult - expression to be executed
 
    # var_AST:AST - AST visitor
    #
    # Throws:
    def Struct.eval(var_Value, var_AST)

      Common::Logger.print(Common::VAR_DEBUG, self, "[struct]: Beginning operation for object name [#{var_Value.to_s()}]")
      Common::Logger.print(Common::VAR_DEBUG, self, "[struct]: #{var_AST.VAR_QRES().to_s()}\n#{var_AST.VAR_ENVS().to_s()}")

      # Evaluating the right side if the expression
      var_Value.execute(var_AST)
      var_ExpressionResult = var_AST.VAR_QRES().pop()
      
      var_StructTmpResult = QRES::StructResult.new()
      var_StructTmpResult.push(var_ExpressionResult)
      
      var_StructResult = QRES::StructResult.new()
      var_StructResult.push(var_StructTmpResult)
      
      var_AST.VAR_QRES().push(var_StructTmpResult)

      Common::Logger.print(Common::VAR_DEBUG, self, "[struct]: After operation, object name [#{var_Value.to_s()}]")
      Common::Logger.print(Common::VAR_DEBUG, self, "[struct]: #{var_AST.VAR_QRES().to_s()}\n#{var_AST.VAR_ENVS().to_s()}")    
    end
  end
end
