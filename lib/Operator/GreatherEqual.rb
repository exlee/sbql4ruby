module Operator
  
require "lib/Operator/AbstractOperator"  
require "lib/Operator/RuntimeException"

require "lib/QRES/Utils"
require "lib/QRES/BooleanResult"

  
  # Class: GreatherEqual
  # Extends: AbstractOperator
  #
  # Class implementing Greater-Equal operator
  # NOTE: We're aware, that class name is typoed, yet
  #       because of high level of complexity we leave it
  #       as is.
  class GreatherEqual < AbstractOperator
    
    # Static Method: eval
    #
    # Evaluates 'greather equal' operator 
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
    # Returns: BooleanResult
    #
    # Throws:AbstractMethodException
    def GreatherEqual.eval(var_LValue, var_RValue, var_QRES, var_ENVS, var_Store)
      Common::Logger.print(Common::VAR_DEBUG, self, "[eval]: #{var_LValue} >= #{var_RValue}")  

      if(!QRES::Utils::isSimpleObject?(var_LValue) && !QRES::Utils::isSimpleObject?(var_RValue))
        raise RuntimeException.new(
          "Incorrect object type: [#{var_LValue}], [#{var_RValue}], expected [#{QRES::AbstractSimpleQueryResult.class.to_s()}]")
      end

      var_LValue = QRES::Utils::dereference(QRES::Utils::getBagResultAsSimpleObject(var_LValue), var_Store)
      var_RValue = QRES::Utils::dereference(QRES::Utils::getBagResultAsSimpleObject(var_RValue), var_Store)
      
      var_QRES.push(QRES::BooleanResult.new(var_LValue >= var_RValue))  
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[eval]: END")  
    end
  end
end
