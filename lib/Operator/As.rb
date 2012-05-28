module Operator

require "lib/Operator/AbstractOperator"  
require "lib/Operator/RuntimeException"

require "lib/QRES/BinderResult"
require "lib/QRES/Utils"

  
  class As < AbstractOperator
    
    # Evaluates 'as' operator 
    #
    # Params:
    #
    # var_Value:AbstractQueryResult - expression to be executed
 
    # var_AST:AST - AST visitor
    #
    # Throws:
    def As.eval(var_Value, var_Name, var_AST)

      Common::Logger.print(Common::VAR_DEBUG, self, "[as]: Beginning operation for object name [#{var_Value.to_s()}]")
      Common::Logger.print(Common::VAR_DEBUG, self, "[as]: #{var_AST.VAR_QRES().to_s()}\n#{var_AST.VAR_ENVS().to_s()}")

      # Evaluating expression
      var_Value.execute(var_AST)
      
      var_ExpressionResult = var_AST.VAR_QRES().pop()
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[as]: Value afetr evaluation: [#{var_ExpressionResult.to_s()}]")
       
      if(QRES::Utils::isSimpleObject?(var_ExpressionResult))
        Common::Logger.print(Common::VAR_DEBUG, self, "[as]: Operator call in context of simple object type: [#{var_ExpressionResult.to_s()}]")
         
        var_AST.VAR_QRES().push(QRES::BinderResult.new(var_Name, var_ExpressionResult))
      else
        iterator = var_ExpressionResult.nestedIterator()
        
        # Result complex objects depends on the given type of complex object
        resultSet = nil
        
        if(var_ExpressionResult.is_a?(QRES::BagResult))
          resultSet = QRES::BagResult.new()
        elsif(var_ExpressionResult.is_a?(QRES::StructResult))
          resultSet = QRES::StructResult.new()
        else
          raise RuntimeException.new(
            "Incorrect object type: [#{var_ExpressionResult.to_s()}], expected [#{QRES::BagResult.class.to_s()}] or [#{QRES::StructResult.calss.to_s()}]")
        end
        
        # Creating binders for all objects provided by the given complex object 
        while(iterator.hasNext())
          object = QRES::BinderResult.new(var_Name, iterator.next())

          Common::Logger.print(Common::VAR_DEBUG, self, "[as]: Operator call in context of simple object type: [#{object.to_s()}]")
           
          resultSet.push(object)   
          
          Common::Logger.print(Common::VAR_DEBUG, self, "[as]: Result set: [#{resultSet.to_s()}]")       
        end
        
         var_AST.VAR_QRES().push(resultSet)          
      end
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[as]: After operation\n#{var_AST.VAR_QRES().to_s()}\n#{var_AST.VAR_ENVS().to_s()}")    
    end
  end
end