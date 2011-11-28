module Operator

require "lib/Operator/AbstractOperator"  
require "lib/Operator/Evaluate"

require "lib/QRES/BagResult"  
  
  class Wheres < AbstractOperator
    
    # Evaluates 'wheres' operator 
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
    def Wheres.eval(var_LValue, var_RValue, var_QRES, var_ENVS, var_Store)
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[wheres]: Beginning operation for l-value [#{var_LValue.to_s()}], r-value [#{var_RValue.to_s()}]")
      Common::Logger.print(Common::VAR_DEBUG, self, "[wheres]: #{var_QRES.to_s()}\n#{var_ENVS.to_s()}")
      
      bagResult = BagResult.new()
      
      # Evaluate specified object
      Evaluate.eval(var_LValue, var_QRES, var_ENVS)
      
      # Getting eval results from QRES stack
      lValueBagResult = var_QRES.pop()
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[wheres]: BagResult taken from the QRES stack [#{lValueBagResult.to_s()}]")
      
      # Bag iterator
      bagIterator = lValueBagResult.iterator()

      while(bagIterator.hasNext())
        object = bagIterator.next()
        
        Common::Logger.print(Common::VAR_DEBUG, self, "[wheres]: Calling nested for object type [#{object.class.to_s()}], data [#{object.to_s()}]")
        Common::Logger.print(Common::VAR_DEBUG, self, "[wheres]: Stacks before nested:\n#{var_QRES.to_s()}\n#{var_ENVS.to_s()}")

        # Nested for the given object
        var_ENVS.nested(object, var_Store)

        # Evaluate specified object
        Evaluate.eval(var_RValue, var_QRES, var_ENVS)
        
        # Getting eval results from QRES stack
        rValueBagResult = var_QRES.pop()
        
        
        
        # Binding the attribute name, pushing into the bag result
        #bagResult.push(var_ENVS.bind(var_AttributeName))

        #var_ENVS.push(bagResult, var_Store)
        #var_ENVS.pop()
      end
        
      end
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[wheres]: After operation:\n#{var_QRES.to_s()}\n#{var_ENVS.to_s()}")
    end
  end
end