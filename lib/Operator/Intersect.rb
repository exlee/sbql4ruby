module Operator
  
require "lib/Operator/AbstractOperator"  
require "lib/Operator/RuntimeException"

require "lib/QRES/BagResult"

require "lib/QRES/Utils"

  
  class Intersect < AbstractOperator
    
    # Evaluates 'intersect' operator 
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
    def Intersect.eval(var_LValue, var_RValue, var_QRES, var_ENVS, var_Store)
      Common::Logger.print(Common::VAR_DEBUG, self, "[eval]: #{var_LValue} INTERSECT #{var_RValue}")  
    
      bagResult = QRES::BagResult.new()
      
      iterator = var_LValue.iterator()
      
      while(iterator.hasNext())
        object = QRES::Utils::dereference(QRES::Utils::getBagResultAsSimpleObject(iterator.next()), var_Store)
        
        if(var_RValue.is_contained?(object))
          bagResult.push(object)
        end
      end
            
      Common::Logger.print(Common::VAR_DEBUG, self, "[eval]: #{bagResult.to_s()}")  
      
      var_QRES.push(bagResult)  
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[eval]: END")  
    end
  end
end