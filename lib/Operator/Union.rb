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
    # var_ObjectName:String - object name
    #
    # var_AttributeName:String - attribute name
    #
    # var_QRES:QRES - qres stack
    #
    # var_ENVS:ENVS - envs stack
    #
    # var_Store:SBAStore - SBA store
    #
    # Returns: AbstractSimpleQueryResult
    #
    # Throws:AbstractMethodException
    def Union.eval(var_LValue, var_RValue, var_QRES, var_ENVS, var_Store)
      Common::Logger.print(Common::VAR_DEBUG, self, "[eval]: #{var_LValue} UNION #{var_RValue}")  

     
      result = QRES::BagResult.new()
      
      result.push(var_LValue)
      result.push(var_RValue)
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[eval]: #{result.to_s()}")  
      
      var_QRES.push(result)  
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[eval]: END")  
    end
  end
end