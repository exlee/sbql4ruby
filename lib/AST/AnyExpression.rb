module AST

require "lib/AST/BinaryExpression"
  

  # Class: AnyExpression
  # Extends: BinaryExpression
  # 
  # Class implementing AnyExpression
  class AnyExpression < BinaryExpression
 
    def initialize(var_LeftExpression, var_RightExpression)
      super(var_LeftExpression, var_RightExpression)
    end
  end
end
