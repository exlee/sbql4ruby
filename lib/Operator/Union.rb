module Operator
  
require "lib/Operator/AbstractOperator"  
require "lib/Operator/RuntimeException"

require "lib/QRES/BagResult"

require "lib/QRES/Utils"

  
  class Union < AbstractOperator
    
    # Evaluates 'union' operator 
    #
    # Params:
    #
    # var_Value:AbstractQueryResult - expression to be executed
 
    # var_AST:AST - AST visitor
    #
    # Throws:
    def Union.eval(var_LValue, var_RValue, var_AST)
      Common::Logger.print(Common::VAR_DEBUG, self, "[eval]: #{var_LValue} UNION #{var_RValue}")  

      # Executing left query side
      var_LValue.execute(var_AST)

      # Executing right query side
      var_RValue.execute(var_AST)

      var_RValue = var_AST.VAR_QRES().pop()
      var_LValue = var_AST.VAR_QRES().pop() 
             
      result = var_LValue.union(var_RValue)
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[eval]: #{result.to_s()}")  
      
      var_AST.VAR_QRES().push(result)  
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[eval]: END")  
    end
  end
end