module AST

require "lib/AST/BinaryExpression"
  

  # Class: AllExpression
  # Extends: BinaryExpression
  #
  # Class representing All expression
  class AllExpression < BinaryExpression
 
    def initialize(var_LeftExpression, var_RightExpression)
      super(var_LeftExpression, var_RightExpression)
    end
  end
end
