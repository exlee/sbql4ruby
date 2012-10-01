module Operator

require "lib/Operator/AbstractOperator"  
require "lib/Operator/Evaluate"

require "lib/QRES/BagResult"

  
  # Class: Dotres
  # Extends: AbstractOperator
  #
  # Class implementing Dotres operator
  class Dotres < AbstractOperator
    
    # Static Method: eval
    #
    # Evaluates 'dotres' operator 
    #
    # Params:
    #
    # var_LValue:AbstractQueryResult - left side of expression
    #
    # var_RValue:AbstractQueryResult - right side of expression
    #
    # var_AST:AST - AST visitor
    #
    # Throws:
    def Dotres.eval(var_LValue, var_RValue, var_AST)
      
      Common::Logger.print(Common::VAR_DEBUG, self, 
        "[dotres]: Beginning operation for object name [#{var_LValue.to_s()}], attribute name [#{var_RValue.to_s()}]")
      Common::Logger.print(Common::VAR_DEBUG, self, "[dotres]: #{var_AST.VAR_QRES().to_s()}\n#{var_AST.VAR_ENVS().to_s()}")

      bagResult = QRES::BagResult.new()

      # It has to be bagresult, add validation here
      bagIterator = var_LValue.iterator()

      Common::Logger.print(Common::VAR_DEBUG, self, "[dotres]: Iterator type [#{bagIterator.to_s()}]")

      while(bagIterator.hasNext())
        object = bagIterator.next()

        Common::Logger.print(Common::VAR_DEBUG, self, "[dotres]: Calling nested for object type [#{object.class.to_s()}], data [#{object.to_s()}]")
        Common::Logger.print(Common::VAR_DEBUG, self, "[dotres]: #{var_AST.VAR_QRES().to_s()}\n#{var_AST.VAR_ENVS().to_s()}")

        # Nested for the given object
        var_AST.VAR_ENVS().nested(object, var_AST.VAR_STORE())

        # Executing the right side of query
        var_RValue.execute(var_AST)

        # Taking query result from QRES stack
        bagResult.push(var_AST.VAR_QRES().pop())
        
        # Removing the last frame from ENVS stack
        var_AST.VAR_ENVS().pop()

        Common::Logger.print(Common::VAR_DEBUG, self, "[dotres]: #{var_AST.VAR_QRES().to_s()}\n#{var_AST.VAR_ENVS().to_s()}")
      end

      var_AST.VAR_QRES().push(bagResult)

      Common::Logger.print(Common::VAR_DEBUG, self, "[dotres]: After operation, object name [#{var_LValue.to_s()}], attribute name [#{var_RValue.to_s()}]")
      Common::Logger.print(Common::VAR_DEBUG, self, "[dotres]: #{var_AST.VAR_QRES().to_s()}\n#{var_AST.VAR_ENVS().to_s()}")    
    end
  end
end
