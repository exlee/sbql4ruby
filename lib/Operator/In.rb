module Operator
  
require "lib/Operator/AbstractOperator"  
require "lib/Operator/RuntimeException"

require "lib/QRES/BagResult"

require "lib/QRES/Utils"

  
  class In < AbstractOperator
    
    # Evaluates 'in' operator 
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
    def In.eval(var_LValue, var_RValue, var_QRES, var_ENVS, var_Store)
      Common::Logger.print(Common::VAR_DEBUG, self, "[eval]: #{var_LValue.to_s()} IN #{var_RValue.to_s()}")  
    
      foundResult = QRES::BagResult.new()
      notFoundResult = QRES::BagResult.new()
      
      iterator = var_LValue.nestedIterator()
      
      objectNotFound = 0
            
      while(iterator.hasNext())
        object = QRES::Utils::dereference(QRES::Utils::getBagResultAsSimpleObject(iterator.next()), var_Store)
        
        if(var_RValue.is_contained?(object))
          foundResult.push(object)
        else
          notFoundResult.push(object)
        end
      end
          
      Common::Logger.print(Common::VAR_DEBUG, self, "[eval]: Obejcts found=#{foundResult.VAR_OBJECT().size().to_s()}, objects not found=#{notFoundResult.VAR_OBJECT().size()}")  
             
      if(notFoundResult.VAR_OBJECT().size()>0)
        foundResult = QRES::BagResult.new()
      end  
      
      var_QRES.push(foundResult)  
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[eval]: END")  
    end
  end
end