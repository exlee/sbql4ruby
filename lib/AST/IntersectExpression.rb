module AST

require "lib/AST/BinaryExpression"
  

  # Class: IntersectExpression
  # Extends: BinaryExpression
  # 
  # Class implementing Intersect expression
  class IntersectExpression < BinaryExpression
 
    def initialize(var_LeftExpression, var_RightExpression)
      super(var_LeftExpression, var_RightExpression)
    end
  end
end
