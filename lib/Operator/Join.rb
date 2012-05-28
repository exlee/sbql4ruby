module Operator

require "lib/Operator/AbstractOperator"  
require "lib/Operator/Evaluate"

require "lib/QRES/BagResult"

  
  class Join < AbstractOperator
    
    # Evaluates 'join' operator 
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
    def Join.eval(var_LValue, var_RValue, var_AST)
      
      Common::Logger.print(Common::VAR_DEBUG, self, 
        "[join]: Beginning operation for object name [#{var_LValue.to_s()}], attribute name [#{var_RValue.to_s()}]")
      Common::Logger.print(Common::VAR_DEBUG, self, "[join]: #{var_AST.VAR_QRES().to_s()}\n#{var_AST.VAR_ENVS().to_s()}")

      bagResult = QRES::BagResult.new()

      _var_LValue = QRES::BagResult.new()
      _var_LValue.push(var_LValue)      

      _LValueIterator = _var_LValue.nestedIterator()

      Common::Logger.print(Common::VAR_DEBUG, self, "[join]: l-value iterator type [#{_LValueIterator.to_s()}]")

      while(_LValueIterator.hasNext())
        _Lobject = _LValueIterator.next()

        Common::Logger.print(Common::VAR_DEBUG, self, "[join]: Calling nested for object type [#{_Lobject.class.to_s()}], data [#{_Lobject.to_s()}]")
        Common::Logger.print(Common::VAR_DEBUG, self, "[join]: #{var_AST.VAR_QRES().to_s()}\n#{var_AST.VAR_ENVS().to_s()}")

        # Nested for the given object
        var_AST.VAR_ENVS().nested(_Lobject, var_AST.VAR_STORE())

        # Executing the right side of query
        var_RValue.execute(var_AST)
        
        _var_RValue = QRES::BagResult.new()
        _var_RValue.push(var_AST.VAR_QRES().pop())        
        
        _RValueIterator = _var_RValue.nestedIterator()
        
        Common::Logger.print(Common::VAR_DEBUG, self, "[join]: r-value iterator type [#{_RValueIterator.to_s()}]")
          
        while(_RValueIterator.hasNext())
           _Robject = _RValueIterator.next()
           
           _ResultStruct = QRES::StructResult.new()
           _ResultStruct.add(_Lobject)
           _ResultStruct.add(_Robject)
      
           bagResult.push(_ResultStruct)
        end
                   
        # Removing the last frame from ENVS stack
        var_AST.VAR_ENVS().pop()

        Common::Logger.print(Common::VAR_DEBUG, self, "[join]: Interaction for l-value=[#{_Lobject.to_s()}], #{var_AST.VAR_QRES().to_s()}\n#{var_AST.VAR_ENVS().to_s()}")
        Common::Logger.print(Common::VAR_DEBUG, self, "[join]: Currect result strucure=[#{bagResult.to_s()}]")
      end

      var_AST.VAR_QRES().push(bagResult)

      Common::Logger.print(Common::VAR_DEBUG, self, "[join]: After operation, object name [#{var_LValue.to_s()}], attribute name [#{var_RValue.to_s()}]")
      Common::Logger.print(Common::VAR_DEBUG, self, "[join]: #{var_AST.VAR_QRES().to_s()}\n#{var_AST.VAR_ENVS().to_s()}")    
    end
  end
end