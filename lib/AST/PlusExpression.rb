module AST

require "lib/AST/BinaryExpression"
  

  class PlusExpression < BinaryExpression
 
    def initialize(var_LeftExpression, var_RightExpression)
      super(var_LeftExpression, var_RightExpression)
    end
  end
end