module AST

require "lib/AST/UnaryExpression"
  

  class BagExpression < UnaryExpression
 
    def initialize(var_Name, var_Expression)
      super(var_Name, var_Expression)
    end
  end
end