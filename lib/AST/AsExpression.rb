module AST

require "lib/AST/UnaryExpression"
  

  # Class: AsExpression
  # Extends: UnaryExpression
  #
  # Class implementing As expression
  class AsExpression < UnaryExpression
 
    def initialize(var_Name, var_Expression)
      super(var_Name, var_Expression)
    end
  end
end
