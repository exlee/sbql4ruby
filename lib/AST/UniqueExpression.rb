module AST

require "lib/AST/UnaryExpression"
  

  # Class: UniqueExpression
  # Extends: UnaryExpression
  #
  # Class implementing Unique expression
  class UniqueExpression < UnaryExpression
 
    def initialize(var_Name, var_Expression)
      super(var_Name, var_Expression)
    end
  end
end
