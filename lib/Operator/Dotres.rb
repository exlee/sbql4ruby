module Operator

require "lib/Operator/AbstractOperator"  
require "lib/Operator/Evaluate"

require "lib/QRES/BagResult"

  
  class Dotres < AbstractOperator
    
    # Evaluates 'dotres' operator 
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
    def Dotres.eval(var_ObjectName, var_AttributeName, var_QRES, var_ENVS, var_Store)
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[dotres]: Beginning operation for object name [#{var_ObjectName}], attribute name [#{var_AttributeName}]")
      Common::Logger.print(Common::VAR_DEBUG, self, "[dotres]: #{var_QRES.to_s()}\n#{var_ENVS.to_s()}")

      bagResult = QRES::BagResult.new()

      # Evaluate specified object
      Evaluate.eval(var_ObjectName, var_QRES, var_ENVS)

      # Getting eval results from QRES stack
      evalBagResult = var_QRES.pop()

      Common::Logger.print(Common::VAR_DEBUG, self, "[dotres]: After QRES.pop()\n#{var_QRES.to_s()}\n#{var_ENVS.to_s()}")

      if(!evalBagResult.is_a?(QRES::BagResult))
        raise DataTypeException.new("Incorrect object type [#{evalBagResult.class}], " + QRES::BagResult.to_s() + " expected")
      end

      bagIterator = evalBagResult.iterator()

      Common::Logger.print(Common::VAR_DEBUG, self, "[dotres]: BagResult taken from the QRES stack [#{evalBagResult}]")
      Common::Logger.print(Common::VAR_DEBUG, self, "[dotres]: Iterator type [#{bagIterator.to_s()}]")

      while(bagIterator.hasNext())
        object = bagIterator.next()

        Common::Logger.print(Common::VAR_DEBUG, self, "[dotres]: Calling nested for object type [#{object.class.to_s()}], data [#{object.to_s()}]")
        Common::Logger.print(Common::VAR_DEBUG, self, "[dotres]: Stacks before nested:\n#{var_QRES.to_s()}\n#{var_ENVS.to_s()}")

        # Nested for the given object
        var_ENVS.nested(object, var_Store)

        # Binding the attribute name, pushing into the bag result
        bagResult.push(var_ENVS.bind(var_AttributeName))

        #var_ENVS.push(bagResult, var_Store)
        var_ENVS.pop()

        Common::Logger.print(Common::VAR_DEBUG, self, "[dotres]: Stacks after nested:\n#{var_QRES.to_s()}\n#{var_ENVS.to_s()}")
      end

      var_QRES.push(bagResult)

      Common::Logger.print(Common::VAR_DEBUG, self, "[dotres]: After operation, object name [#{var_ObjectName}], attribute name [#{var_AttributeName}]")
      Common::Logger.print(Common::VAR_DEBUG, self, "[dotres]: #{var_QRES.to_s()}\n#{var_ENVS.to_s()}")    
    end
  end
end