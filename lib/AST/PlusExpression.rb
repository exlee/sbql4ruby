module AST

require "lib/AST/BinaryExpression"
  

  class PlusExpression < BinaryExpression
 
    def initialize(var_LeftExpression, var_RightExpression)
      super(var_LeftExpression, var_RightExpression)
    end
    
    def execute(var_QRES, var_ENVS)
      Common::Logger.print(Common::VAR_DEBUG, self, "[visit]: Executing opeartor: [#{self.to_s()}]")
      
      # Executing left and right expressions
      self.getLeftExpression().execute()
      self.getRightExpression().execute()
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[visit]: #{var_QRES.to_s()}\n#{var_ENVS.to_s()}")
    end
  end
end