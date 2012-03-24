module Operator

require "lib/Operator/AbstractOperator"  
require "lib/QRES/BagResult"
 
  
  # Class: Evaluate
  # Extends: AbstractOperator
  # 
  # Class implementing Evaluate operator
  class Evaluate < AbstractOperator

    # Static Method: eval
    #
    # Evaluates 'evaluate' operator 
    #
    # Params:
    #
    # var_Name:String - object name
    #
    # var_QRES:QRES - qres stack
    #
    # var_ENVS:ENVS - envs stack
    #
    # Returns:
    #
    # Throws:AbstractMethodException    
    def Evaluate.eval(var_Name, var_QRES, var_ENVS)
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[eval]: Beginning operation for object name [#{var_Name}]\n#{var_QRES.to_s()}\n#{var_ENVS.to_s()}")
      
      var_QRES.push(var_ENVS.bind(var_Name))
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[eval]: After operation, object name [#{var_Name}]\n#{var_QRES.to_s()}\n#{var_ENVS.to_s()}")
    end
  end
end
