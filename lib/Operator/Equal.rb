module Operator
  
require "lib/Operator/AbstractOperator"  
require "lib/Operator/RuntimeException"

require "lib/QRES/Utils"

  
  class Equal < AbstractOperator
    
    # Evaluates 'equal' operator 
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
    # Returns:
    #
    # Throws:AbstractMethodException
    def Minus.eval(var_LValue, var_RValue, var_QRES, var_ENVS, var_Store)
      Common::Logger.print(Common::VAR_DEBUG, self, "[eval]: #{var_LValue} - #{var_RValue}")  

      if(!QRES::Utils::isSimpleObject?(var_LValue) && !QRES::Utils::isSimpleObject?(var_RValue))
        raise RuntimeException.new(
          "Incorrect object type: [#{var_LValue}], [#{var_RValue}], expected [#{QRES::AbstractSimpleQueryResult.class.to_s()}]")
      end

      var_LValue = QRES::Utils::getBagResultAsSimpleObject(var_LValue)
      var_RValue = QRES::Utils::getBagResultAsSimpleObject(var_RValue)
      
      var_QRES.push(var_LValue = var_RValue)  
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[eval]: END")  
    end
  end
end